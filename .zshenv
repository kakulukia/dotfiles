
# nicer path configuration and lookup
function path {
  if [[ $# -eq 0 ]]; then
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
#  add some more common defaults
path . # no need to use ./ to execute local scripts
path /bin
path /sbin
path /usr/bin
path /usr/local/bin
path ~/bin
# in case of weird paths problems: check /etc/zprofile on OSX and do not start the path_helper

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN ]]; then
  source ~/.zshrc
fi

# include local, unversioned settings
[[ -e ~/.profile ]] && source ~/.profile
