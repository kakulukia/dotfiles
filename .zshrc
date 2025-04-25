# load benchmak module
# zmodload zsh/zprof

# Add additional directories to load prezto modules from
zstyle ':prezto:load' pmodule-dirs $HOME/.zprezto-contrib
# Color output (auto set to 'no' on dumb terminals).
zstyle ':prezto:*:*' color 'yes'

# Set the Prezto modules to load (browse modules).
# The order matters.
zstyle ':prezto:load' pmodule \
  'directory' \
  'history' \
  'completion' \
  'autosuggestions' \
  'syntax-highlighting' \
  'history-substring-search' \
  'history-search-multi-word' \
  'fzf-tab' \
  'archive'

# fallback for ARM systems - for now ..
zstyle ':prezto:module:prompt' theme 'minimal'
zstyle ':prezto:module:prompt' show-return-val 'no'

# Set the command prefix on non-GNU systems.
# zstyle ':prezto:module:gnu-utility' prefix 'g'

### Syntax Highlighting
zstyle ':prezto:module:syntax-highlighting' highlighters 'main' 'brackets' 'pattern'
zstyle ':prezto:module:syntax-highlighting' styles 'path' 'fg=cyan'
zstyle ':prezto:module:syntax-highlighting' pattern 'rm*-rf*' 'fg=white,bold,bg=red'

### HISTORY SEARCH OPTIONS
zstyle ":history-search-multi-word" highlight-color "fg=white,bg=yellow"
zstyle ":plugin:history-search-multi-word" synhl "yes"  # Whether to perform syntax highlighting (default true)
zstyle ":plugin:history-search-multi-word" active "bg=59"
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt INC_APPEND_HISTORY SHARE_HISTORY

COMPLETION_WAITING_DOTS="true"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"
zstyle ':prezto:module:completion' dumpfile "$HOME/.cache/prezto/zcompdump"
# Disable grouping headers
zstyle ':fzf-tab:*' show-group none
PROMPT_EOL_MARK=⏎

# Source Prezto
source "$HOME/.zprezto/init.zsh"
[[ -f ~/.alias ]] && source ~/.alias

#### Tmux
## Auto start a session when Zsh is launched in a local terminal.
#zstyle ':prezto:module:tmux:auto-start' local 'no'
## Auto start a session when Zsh is launched in a SSH connection.
#zstyle ':prezto:module:tmux:auto-start' remote 'no'

# initialize tools - brew first to have all brew tools in the path
[ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"
(( $+commands[direnv] )) 2>&1 && eval "$(direnv hook zsh)"
(( $+commands[zoxide] )) 2>&1 && eval "$(zoxide init zsh)"
(( $+commands[starship] )) && eval "$(starship init zsh)"
(( $+commands[fnm] )) && eval "$(fnm env --use-on-cd --shell zsh)"
(( $+commands[fd] )) && export FZF_DEFAULT_COMMAND='fd --type f'


# misc
export PYTHONBREAKPOINT=ipdb.set_trace

# include local, unversioned settings
[[ -e ~/.profile ]] && source ~/.profile

# show benchmark results
# zprof
