#!zsh

function msg() {
  foo="$*"
  # ISF=''
  for (( i=0; i<${#foo}; i++ )); do
    schlaf=$((($RANDOM % 10) * 0.01 + 0.01))
    echo -ne "${foo:$i:1}"
    sleep $(($schlaf))s
  done
  echo ''
  sleep 1s

}

msg Hi!
msg "Let's have a look at some features .. we will start a background job"
redis-server &
msg "The lil icon will display, that there is something running in the background"