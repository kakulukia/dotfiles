#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# nicer path configuration and lookup
function path {
  if [ $# -eq 0 ]; then
    echo -e ${PATH//:/\\n} | sort
  elif [[ "$1" == "--save" ]]; then
    path $2 && echo "\npath $2" >> $HOME/.profile
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

# starting clean
export PATH="/usr/sbin"

path . # no need to use ./ to execute local scripts
path ~/bin
path /bin
path /sbin
path /usr/bin
path /usr/sbin
path /usr/local/bin
# in case of weird paths problems: check /etc/paths and /ets/path.d

# include local settings
[[ -e ~/.profile ]] && source ~/.profile

# initialize pyenv and direnv for all shells
if [ -d "$HOME/.pyenv" ]; then
  path ~/.pyenv/bin
  eval "$(pyenv init -)"
fi
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

