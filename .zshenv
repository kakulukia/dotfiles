
# nicer path configuration and lookup
function path {
  case "$1" in
    "--save")
      shift
      for dir in "$@"; do
        if [[ -d "$dir" ]]; then
          if ! grep -q "path $dir" "$HOME/.profile"; then
            echo "path $dir" >> "$HOME/.profile"
          fi
          path "$dir"  # Direkt setzen
        else
          echo "$dir does not exist :("
        fi
      done
      ;;

    "")
      echo "sorted .."
      echo -e "$(echo $PATH | tr ':' '\n' | sort)"
      ;;

    "-o")
      echo -e "current order .."
      echo -e "$(echo $PATH | tr ':' '\n')"
      ;;

    *)
      for dir in "$@"; do
        if [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]]; then
          export PATH="$dir:$PATH"
        fi
      done
      ;;
  esac
}

# export full PATH after loading the shell
export PATH="/usr/sbin:.:/bin:/sbin:/usr/bin:/usr/local/bin:~/bin"

# in case of weird paths problems: check /etc/zprofile on OSX and do not start the path_helper
# which messes with the path and tends to reorder it - very bad!

# Ensure that all shells have a defined environment.
if [[ ! -o login && ! -o interactive ]]; then
  . $HOME/.zshrc
fi

# include local, unversioned settings
[[ -e ~/.profile ]] && source ~/.profile
