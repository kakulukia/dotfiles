#!/bin/bash

GHAR=${REMOTE:-https://github.com/philips/ghar.git}
DOTFILES=${REMOTE:-git://github.com/kakulukia/dotfiles.git}

apt=`command -v apt-get`
yum=`command -v yum`
brew=`command -v brew`

## Detect the systems installer
if [ -n "$apt" ]; then
    INSTALL='sudo apt-get -y install'
elif [ -n "$yum" ]; then
    INSTALL='sudo yum -y install'
elif [ -n "$brew" ]; then
    INSTALL='brew install'
else
    echo "Error: Your OS is not supported :(" >&2;
    exit 1;
fi

green () {
  out='\033[0;32m'
  NC='\033[0m'
  echo -e "${out}${1}${NC}"
}
red () {
  out='\033[0;31m'
  NC='\033[0m'
  echo -e "${out}${1}${NC}"
}

## test if command exists
check () {
  green "Checking for ${1} .."
  if type -f "${1}" > /dev/null 2>&1; then
    return 1
  else
    green "Installing ${1}"
    return 0
  fi
}

## main setup
setup () {
  echo ""
  green "installing dotfiles .."
  ## test for require features
  check git && $INSTALL git
  check zsh && $INSTALL zsh
  check pip3 && $INSTALL python3 python3-pip

  echo ""
  green "Cloning the repo .."
  cd
  git clone https://github.com/philips/ghar.git
  cd ghar
  git clone --recursive git://github.com/kakulukia/dotfiles.git

  # install pyenv, activate and install python3 if necessary
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper
  PYENV_ROOT="$HOME/.pyenv"
  PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
#  command -v python3 || pyenv install 3.8.2 && pyenv global 3.8.2

  #installing dotfiles symlinks
  python3 bin/ghar install

  echo ""
  green "Installing fasd .."
  cd /tmp
  wget https://github.com/clvv/fasd/archive/1.0.1.tar.gz
  tar xzfv 1.0.1.tar.gz
  cd /tmp/fasd-1.0.1
  sudo make install

  echo ""
  cd
  cd ghar/dotfiles/misc/
  mkdir -p ~/.config/colorls
  path=`pwd`
  ln -s $path/dark_colors.yaml ~/.config/colorls/
  zsh install-additional-stuff.sh

  echo ""
  echo ""
  green "Changing your default login shell to zsh .."
  sudo chsh -s `which zsh` `whoami`
  echo ""
  green "Have fun with your new shell!"
  echo "type zsh to start it or just login again .."
  echo ""
  echo ""

}

setup
