### Editors
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

# Language
export LANG='de_DE.UTF-8'

# Add additional directories to load prezto modules from
zstyle ':prezto:load' pmodule-dirs $HOME/.zprezto-contrib
# Color output (auto set to 'no' on dumb terminals).
zstyle ':prezto:*:*' color 'yes'

# Set the Prezto modules to load (browse modules).
# The order matters.
zstyle ':prezto:load' pmodule \
  'history' \
  'syntax-highlighting' \
  'history-substring-search' \
  'history-search-multi-word' \
  'autosuggestions' \
  'archive' \
  'fzf-tab' \
  'completion' \
  'terminal'

# Set the command prefix on non-GNU systems.
# zstyle ':prezto:module:gnu-utility' prefix 'g'

### Syntax Highlighting
zstyle ':prezto:module:syntax-highlighting' highlighters \
  'main' \
  'brackets' \
  'pattern'
# Set syntax highlighting styles.
zstyle ':prezto:module:syntax-highlighting' styles \
  'builtin' 'fg=green' \
  'command' 'fg=green' \
  'function' 'fg=green' \
  'path' 'fg=cyan'
# Set syntax pattern styles.
zstyle ':prezto:module:syntax-highlighting' pattern \
  'rm*-rf*' 'fg=white,bold,bg=red'

# HISTORY SEARCH OPTIONS
zstyle ":history-search-multi-word" highlight-color "fg=white,bg=yellow"
zstyle ":plugin:history-search-multi-word" synhl "yes"                 # Whether to perform syntax highlighting (default true)
zstyle ":plugin:history-search-multi-word" active "bg=59"
# HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
zstyle ':completion:*' special-dirs true

# Source Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# unset preztos annoying grouping feature
zstyle -d ':completion:*:matches' group
zstyle -d ':completion:*:*:*:*:*' menu
zstyle -d ':completion:*:options' description
zstyle -d ':completion:*' group-name
zstyle -d ':completion:*' verbose
zstyle -d ':completion:*:options' auto-description
zstyle -d ':completion:*:corrections' format
zstyle -d ':completion:*:descriptions' format
zstyle -d ':completion:*:messages' format
zstyle -d ':completion:*:warnings' format
zstyle -d ':completion:*:default' list-prompt
zstyle -d ':completion:*' format


# load aliases and  the prompt
source .alias
eval "$(starship init zsh)"


# misc
export PYTHONBREAKPOINT=ipdb.set_trace

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

eval "$(fasd --init auto)"
