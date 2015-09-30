ZSH
===

    apt-get install zsh git
    chsh -s /usr/bin/zsh
    sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

dotfiles
========
    cd
    git clone https://github.com/philips/ghar.git
    cd ghar
    git clone --recursive git://github.com/kakulukia/dotfiles.git andy
    bin/ghar install
