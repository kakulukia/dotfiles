#!/bin/bash

GHAR=${REMOTE:-https://github.com/philips/ghar.git}
DOTFILES=${REMOTE:-git://github.com/kakulukia/dotfiles.git}

apt=`command -v apt-get`
yum=`command -v yum`
brew=`command -v brew`

## Detect the systems installer
if [ -n "$apt" ]; then
    INSTALL='sudo apt -y install'
elif [ -n "$yum" ]; then
    INSTALL='sudo yum -y install'
elif [ -n "$brew" ]; then
    INSTALL='brew install'
else
    echo "Error: You OS is not supported :(" >&2;
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
  chsh -s /usr/bin/zsh

  echo ""
  green "cloning the repo .."
  cd
  git clone https://github.com/philips/ghar.git
  cd ghar
  git clone --recursive git://github.com/kakulukia/dotfiles.git
  bin/ghar install

  if [ -n "$yum" ]; then
    sudo rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
    sudo yum -y install python34
    sudo curl --silent https://bootstrap.pypa.io/get-pip.py | sudo python
  else
    check pip3 && $INSTALL python3-pip
    #$INSTALL python-dev
    sudo pip3 install virtualenvwrapper
    #sudo pip3 install psutil
  fi

  echo ""
  green "installing fasd .."
  cd /tmp
  wget https://github.com/clvv/fasd/archive/1.0.1.tar.gz
  tar xzfv 1.0.1.tar.gz
  cd /tmp/fasd-1.0.1
  sudo make install


  echo ""
  echo ""
  green "Have fun with your new shell!"
  echo "type zsh to start it"
  echo ""
  echo ""

}

setup
