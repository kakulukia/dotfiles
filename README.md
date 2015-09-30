ZSH
===

    apt-get/brew install zsh git

Settings ZSH as the default shell.
    
    chsh -s /usr/bin/zsh

install the dotfiles repo
=========================

    cd
    git clone https://github.com/philips/ghar.git
    cd ghar
    git clone --recursive git://github.com/kakulukia/dotfiles.git andy
    bin/ghar install
