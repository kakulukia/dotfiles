# Path to your oh-my-dzsh installation.
export ZSH=~/.oh-my-zsh

ZSH_DISABLE_COMPFIX=false
ZSH_THEME="bullet-train"
HYPHEN_INSENSITIVE="true" # _ and - will be interchangeable.
unsetopt correct_all
setopt correct
COMPLETION_WAITING_DOTS="true"
ZSH_CUSTOM=~/.zsh-custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  kubectl
  docker
  extract
  virtualenvwrapper
  fasd
  zsh-autosuggestions
  zsh-explain-shell
  history-search-multi-word
  zsh-completions
  zsh-syntax-highlighting
  history-substring-search
)
autoload -U compinit && compinit

# syntax highlighting has to be loaded last
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
zstyle ':bracketed-paste-magic' active-widgets '.self-*'
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
# To have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
# To disable highlighting of globbing expressions
ZSH_HIGHLIGHT_STYLES[globbing]='none'

# HISTORY SEARCH OPTIONS
zstyle ":history-search-multi-word" highlight-color "fg=white,bg=yellow"
zstyle ":plugin:history-search-multi-word" synhl "yes"                 # Whether to perform syntax highlighting (default true)
zstyle ":plugin:history-search-multi-word" active "bold"          # Effect on active history entry. Try: standout, bold, bg=blue (default underline)

# nicer path configuration and lookup
function path {
  if [ $# -eq 0 ]; then
    echo -e ${PATH//:/\\n} | sort
  elif [[ "$1" == "--save" ]]; then
    path $2 && echo "path $2" >> $HOME/.profile
  else
    if [[ -d "$1" ]] ; then
      if [[ -z "$PATH" ]] ; then
        export PATH=$1
      else
        export PATH=$1:$PATH
      fi
    else
      echo "$1 does not exist :("
      return 1
    fi
  fi
}
#starting clean
export PATH="/usr/bin"

path . # no need to use ./ to execute local scripts
path ~/bin
path /bin
path /sbin
path /usr/local/bin
path /usr/local/sbin
path /usr/sbin

source $ZSH/oh-my-zsh.sh
# You may need to manually set your language environment
export LANG=de_DE.UTF-8
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs, plugins, and themes.
source ~/.alias

# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"
HISTFILE=~/.history
SAVEHIST=10000
HISTSIZE=10000
setopt SHARE_HISTORY # Killer: share history between multiple shells
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE # If a line starts with a space, dont save it.
setopt HIST_NO_STORE

# testing if we need thse colors
# host_color=cyan
# history_color=yellow
# user_color=green
# root_color=red
# directory_color=magenta
# error_color=red
# jobs_color=green
# zstyle ':completion:*' special-dirs true
export REPORTTIME=1

# include local settings
[[ -e ~/.profile ]] && source ~/.profile

# Bind keypad
############################
# 0 . , Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[On" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"
bindkey -s "^[OX" "="

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [ -d "$HOME/.pyenv" ]; then
  PYENV_ROOT="$HOME/.pyenv"
  PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  if which pyenv-virtualenv-init > /dev/null; then pyenv virtualenvwrapper_lazy; fi
fi

export PIPENV_VENV_IN_PROJECT=1
export PYTHONBREAKPOINT=ipdb.set_trace
export VIRTUALENVWRAPPER_PYTHON=`which python`
export PROMPT_EOL_MARK=""
export TERM=xterm-256color

zle-upify() {
    buf="$(echo "$BUFFER" | sed 's/[ |]*$//')"
    tmp="$(mktemp)"
    eval "$buf |& up --unsafe-full-throttle -o '$tmp' 2>/dev/null"
    cmd="$(tail -n +2 "$tmp")"
    rm -f "$tmp"
    BUFFER="$BUFFER | $cmd"
    zle end-of-line
}
zle -N zle-upify

# use ctrl+p to invoke and ctrl+x to close and use the result
bindkey '^P' zle-upify
