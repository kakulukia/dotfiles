# load benchmak module
# zmodload zsh/zprof

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
  'directory' \
  'history' \
  'history-substring-search' \
  'history-search-multi-word' \
  'autosuggestions' \
  'completion' \
  'fzf-tab' \
  'fzf-fasd' \
  'syntax-highlighting' \
  'archive' \
  'pyenv-lazy' \
  # 'prompt' \
  # 'docker' \
#  'terminal' \

# fallback for ARM systems - for now ..
zstyle ':prezto:module:prompt' theme 'minimal'
zstyle ':prezto:module:prompt' show-return-val 'no'

# Set the command prefix on non-GNU systems.
# zstyle ':prezto:module:gnu-utility' prefix 'g'


# init homebrew for apple silicon - needed for direnv
# needs to happen before plugin loading, so that pyenv pip comes first in PATH
[ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# put this dir before homebrew bin in the path to ensure using the right node app
path /usr/local/bin

### Syntax Highlighting
zstyle ':prezto:module:syntax-highlighting' highlighters \
  'main' \
  'brackets' \
  'pattern'
# Set syntax highlighting styles.
zstyle ':prezto:module:syntax-highlighting' styles \
  'path' 'fg=cyan'
# Set syntax pattern styles.
zstyle ':prezto:module:syntax-highlighting' pattern \
  'rm*-rf*' 'fg=white,bold,bg=red'

# HISTORY SEARCH OPTIONS
zstyle ":history-search-multi-word" highlight-color "fg=white,bg=yellow"
zstyle ":plugin:history-search-multi-word" synhl "yes"                 # Whether to perform syntax highlighting (default true)
zstyle ":plugin:history-search-multi-word" active "bg=59"

COMPLETION_WAITING_DOTS="true"
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"
zstyle ':prezto:module:completion' dumpfile "$HOME/.cache/prezto/zcompdump"

# Source Prezto
source "$HOME/.zprezto/init.zsh"
## unset preztos annoying grouping feature
zstyle ':completion:*' format ' -- %d --'

#### Tmux
## Auto start a session when Zsh is launched in a local terminal.
#zstyle ':prezto:module:tmux:auto-start' local 'no'
## Auto start a session when Zsh is launched in a SSH connection.
#zstyle ':prezto:module:tmux:auto-start' remote 'no'

# initialize direnv
(( $+commands[direnv] )) 2>&1 && eval "$(direnv hook zsh)"

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
eval "$(fasd --init auto)"  # 35ms :(
# load aliases and  the prompt
source ~/.alias
(( $+commands[starship] )) && eval "$(starship init zsh)"

upify() {
    buf="$(echo "${BUFFER}" | sed 's/[ |]*$//')"
    tmp="$(mktemp)"
    eval "${buf} |& up --unsafe-full-throttle -o '$tmp' 2>/dev/null"
    cmd="$(tail -n +2 "$tmp")"
    rm -f "$tmp"
    BUFFER="${BUFFER} | ${cmd}"
    zle end-of-line
}
zle -N upify
# use Ctrl+P to invoke and Ctrl+X to close and use the result
bindkey '^P' upify

PROMPT_EOL_MARK=⏎

# fast node manager
(( $+commands[fnm] )) && eval "$(fnm env --use-on-cd --shell zsh)"

# Setting fd as the default source for fzf
(( $+commands[fd] )) && export FZF_DEFAULT_COMMAND='fd --type f'

# misc
export PYTHONBREAKPOINT=ipdb.set_trace
if [[ "$(uname)" != "Darwin" ]]; then
    export TERM=xterm-256color
fi

# show benchmark results
# zprof
