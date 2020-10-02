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
path /usr/local/bin

# include local settings
[[ -e ~/.profile ]] && source ~/.profile

# initialize direnv and pyenv
if [ -d "$HOME/.pyenv" ]; then
  PYENV_ROOT="$HOME/.pyenv"
  PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  if which pyenv-virtualenv-init > /dev/null; then pyenv virtualenvwrapper_lazy; fi
fi
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
