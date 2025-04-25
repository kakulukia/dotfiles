
### Editors & Defaults
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

export TERM=xterm-ghostty
export XDG_RUNTIME_DIR="$HOME/.cache/"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

export LANG='de_DE.UTF-8'
export PATH="/usr/sbin:.:/bin:/sbin:/usr/bin:/usr/local/bin:$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.fzf/bin"
# in case of weird paths problems: check /etc/zprofile on OSX and do not start the path_helper
# which messes with the path and tends to reorder it - very bad!

{
  # Compile the completion dump to increase startup speed.
  zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# Ensure that all shells have a defined environment.
if [[ ! -o login && ! -o interactive ]]; then
  . $HOME/.zshrc
fi
