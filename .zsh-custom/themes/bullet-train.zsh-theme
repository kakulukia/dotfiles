# README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
#
# In addition, I recommend the
# [Tomorrow Night theme](https://github.com/chriskempson/tomorrow-theme) and, if
# you're using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over
# Terminal.app - it has significantly better color fidelity.

# ------------------------------------------------------------------------------
# CONFIGURATION
# The default configuration, that can be overwrite in your .zshrc file
# ------------------------------------------------------------------------------

VIRTUAL_ENV_DISABLE_PROMPT=true

# PROMPT
BULLETTRAIN_PROMPT_CHAR=""
BULLETTRAIN_PROMPT_ROOT=true
BULLETTRAIN_PROMPT_SEPARATE_LINE=false

# STATUS
BULLETTRAIN_STATUS_SHOW=true
BULLETTRAIN_STATUS_EXIT_SHOW=false
BULLETTRAIN_STATUS_BG=green
BULLETTRAIN_STATUS_ERROR_BG=red
BULLETTRAIN_STATUS_FG=white

# TIME
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_TIME_BG=white
BULLETTRAIN_TIME_FG=black

# VIRTUALENV
BULLETTRAIN_VIRTUALENV_SHOW=true
BULLETTRAIN_VIRTUALENV_BG=green
BULLETTRAIN_VIRTUALENV_FG=white
BULLETTRAIN_VIRTUALENV_PREFIX="⬡"

# DIR
BULLETTRAIN_DIR_SHOW=true
BULLETTRAIN_DIR_BG=008
BULLETTRAIN_DIR_FG=white
BULLETTRAIN_DIR_CONTEXT_SHOW=false
BULLETTRAIN_DIR_EXTENDED=1

# GIT
BULLETTRAIN_GIT_SHOW=true
BULLETTRAIN_GIT_BG=237
BULLETTRAIN_GIT_FG=white
BULLETTRAIN_GIT_DIRTY_FG=red
BULLETTRAIN_GIT_EXTENDED=true

# CONTEXT
BULLETTRAIN_CONTEXT_SHOW=true
BULLETTRAIN_CONTEXT_BG=033
BULLETTRAIN_CONTEXT_SSH_BG=208
BULLETTRAIN_CONTEXT_FG=015

# GIT PROMPT
ZSH_THEME_GIT_PROMPT_PREFIX="⎇ "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_ADDED=" %F{green}✚%F{black}"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %F{blue}✹%F{black}"
ZSH_THEME_GIT_PROMPT_DELETED=" %F{red}✖%F{black}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{yellow}✭%F{black}"
ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
ZSH_THEME_GIT_PROMPT_AHEAD=" ↑"
ZSH_THEME_GIT_PROMPT_BEHIND=" ↓"
ZSH_THEME_GIT_PROMPT_DIVERGED=" ⬍"


# ------------------------------------------------------------------------------
# SEGMENT DRAWING
# A few functions to make it easy and re-usable to draw segmented prompts
# ------------------------------------------------------------------------------

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

# ------------------------------------------------------------------------------
# PROMPT COMPONENTS
# Each component will draw itself, and hide itself if no information needs
# to be shown
# ------------------------------------------------------------------------------

# Context: user@hostname (who am I and where am I)
context() {
  local user="$(whoami)"
  #[[ "$user" != "$BULLETTRAIN_CONTEXT_DEFAULT_USER" || -n "$SSH_CLIENT" ]] && echo -n "${user}@%m"
  if [[ -n "$SSH_CLIENT" ]]; then
    echo -n "⌁ ${user}@%m"
  else
    echo "$USER"
  fi
}
prompt_context() {
  [[ $BULLETTRAIN_CONTEXT_SHOW == false ]] && return

  local _context="$(context)"
  local background=$BULLETTRAIN_CONTEXT_BG
  [[ -n "$SSH_CLIENT" ]] && background=$BULLETTRAIN_CONTEXT_SSH_BG
  [[ $UID -eq 0 ]] && background=red
  
  [[ -n "$_context" ]] && prompt_segment $background $BULLETTRAIN_CONTEXT_FG "$_context"
}

# Git
prompt_git() {
  if [[ $BULLETTRAIN_GIT_SHOW == false ]]; then
    return
  fi

  is_dirty() {
    test -n "$(git status --porcelain --ignore-submodules)"
  }
  
  local git_status="$(git status -b --porcelain 2> /dev/null)"
  local ahead_re='.+ahead ([0-9]+).+'
  local behind_re='.+behind ([0-9]+).+'

  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    
    if is_dirty; then
      prompt_segment $BULLETTRAIN_GIT_BG $BULLETTRAIN_GIT_DIRTY_FG
    else
      prompt_segment $BULLETTRAIN_GIT_BG $BULLETTRAIN_GIT_FG
    fi

    local BRANCH_INFO=""
    [[ "${git_status}" =~ ${ahead_re} ]] && BRANCH_INFO+="${ZSH_THEME_GIT_PROMPT_AHEAD}$match"
    [[ "${git_status}" =~ ${behind_re} ]] && BRANCH_INFO+="${ZSH_THEME_GIT_PROMPT_BEHIND}$match"

    echo -n $(git_prompt_info)$BRANCH_INFO
    
  fi
}

# Dir: current working directory
prompt_dir() {
  if [[ $BULLETTRAIN_DIR_SHOW == false ]]; then
    return
  fi

  local dir=''
  local _context="$(context)"
  [[ $BULLETTRAIN_DIR_CONTEXT_SHOW == true && -n "$_context" ]] && dir="${dir}${_context}:"

  if [[ $BULLETTRAIN_DIR_EXTENDED == 0 ]]; then
    #short directories
    dir="${dir}%1~"
  elif [[ $BULLETTRAIN_DIR_EXTENDED == 2 ]]; then
    #long directories
    dir="${dir}%0~"
  else
    #medium directories (default case)
    dir="${dir}%4(c:...:)%3c"
  fi

  prompt_segment $BULLETTRAIN_DIR_BG $BULLETTRAIN_DIR_FG $dir
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  if [[ $BULLETTRAIN_VIRTUALENV_SHOW == false ]]; then
    return
  fi

  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment $BULLETTRAIN_VIRTUALENV_BG $BULLETTRAIN_VIRTUALENV_FG $BULLETTRAIN_VIRTUALENV_PREFIX" $(basename $virtualenv_path)"
  fi
}

prompt_time() {
  if [[ $BULLETTRAIN_TIME_SHOW == false ]]; then
    return
  fi

  if [[ $BULLETTRAIN_TIME_12HR == true ]]; then
    prompt_segment $BULLETTRAIN_TIME_BG $BULLETTRAIN_TIME_FG %D{%r}
  else
    prompt_segment $BULLETTRAIN_TIME_BG $BULLETTRAIN_TIME_FG %D{%X}
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  if [[ $BULLETTRAIN_STATUS_SHOW == false ]]; then
    return
  fi

  local symbols
  symbols=()
  [[ $RETVAL -ne 0 && $BULLETTRAIN_STATUS_EXIT_SHOW != true ]] && symbols+="✘"
  [[ $RETVAL -ne 0 && $BULLETTRAIN_STATUS_EXIT_SHOW == true ]] && symbols+="✘ $RETVAL"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="⚙"

  if [[ -n "$symbols" && $RETVAL -ne 0 ]]; then
    prompt_segment $BULLETTRAIN_STATUS_ERROR_BG $BULLETTRAIN_STATUS_FG "$symbols"
  elif [[ -n "$symbols" ]]; then
    prompt_segment $BULLETTRAIN_STATUS_BG $BULLETTRAIN_STATUS_FG "$symbols"
  fi

}

# Prompt Character
prompt_char() {
  echo -n $bt_prompt_char
}

# ------------------------------------------------------------------------------
# MAIN
# Entry point
# ------------------------------------------------------------------------------

build_prompt() {
  RETVAL=$?
  prompt_time
  prompt_context
  prompt_status
  prompt_virtualenv
  prompt_git
  prompt_dir
  prompt_end
}

if [[ $BULLETTRAIN_PROMPT_SEPARATE_LINE == true ]] then
  PROMPT='
%{%f%b%k%}$(build_prompt)
%{${fg_bold[default]}%}$(prompt_char) %{$reset_color%}'
else
  PROMPT='%{%f%b%k%}$(build_prompt)%{${fg_bold[default]}%} $(prompt_char)%{$reset_color%}'
fi
