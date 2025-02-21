#!/bin/bash

GHAR=${REMOTE:-git://github.com/philips/ghar.git}
DOTFILES=${REMOTE:-git@github.com:kakulukia/dotfiles.git}

apt=`command -v apt-get`
yum=`command -v yum`
brew=`command -v brew`

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

## Detect the systems installer
green "detecting OS .."
if [ -n "$apt" ]; then
    INSTALL='apt-get -y install'
    if [ $EUID -ne 0 ]; then
       INSTALL='sudo '$INSTALL
    fi
elif [ -n "$yum" ]; then
    INSTALL='yum -y install'
    if [ $EUID -ne 0 ]; then
       INSTALL='sudo '$INSTALL
    fi
elif [ -n "$brew" ]; then
    INSTALL='brew install'
else
    echo "Error: Your OS is not supported :(\nOr you might need to install Homebrew first?" >&2;
    exit 1;
fi

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
  check wget && $INSTALL wget
  check python3 && $INSTALL python3
  check make && $INSTALL make

  echo ""
  green "Cloning the repo .."
  cd
  git clone https://github.com/philips/ghar.git
  cd ghar
  git clone --recursive https://github.com/kakulukia/dotfiles.git

  # install pyenv, activate and install python3 if necessary
  # git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  # git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper
  # PYENV_ROOT="$HOME/.pyenv"
  # PATH="$PYENV_ROOT/bin:$PATH"
  # eval "$(pyenv init -)"
  # command -v python3 || pyenv install 3.8.2 && pyenv global 3.8.2

  #installing dotfiles symlinks
  python3 bin/ghar install

  echo ""
  green "Installing fasd .."
  cd /tmp
  wget https://github.com/clvv/fasd/archive/1.0.1.tar.gz
  tar xzfv 1.0.1.tar.gz
  cd /tmp/fasd-1.0.1
  if [ $EUID -ne 0 ]; then
    sudo make install
  else
    make install
  fi

  echo ""
  cd
  cd ghar/dotfiles/misc/
  mkdir -p ~/.config/lsd
  path=$(pwd)
  ln -s $path/colors.yaml ~/.config/lsd/
  ln -s $path/config.yaml ~/.config/lsd/
  green "Installing starship .."
  command -v starship >/dev/null 2>&1 || curl -fsSL https://starship.rs/install.sh | sh -s -- -y > /dev/null 2>&1
  ln -s ~/ghar/dotfiles/misc/starship.toml ~/.config
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --bin > /dev/null 2>&1

  zsh install-additional-stuff.sh

  echo ""
  echo ""
  green "Changing your default login shell to zsh ..."
  echo "chsh -s $(which zsh) $(whoami)"
  if [ $EUID -ne 0 ]; then
    sudo chsh -s $(which zsh) $(whoami)
  else
    chsh -s $(which zsh) $(whoami)
  fi
  echo ""
  green "Have fun with your new shell!"
  echo "type zsh to start it or just login again .."
  echo ""
  echo ""

}

setup
