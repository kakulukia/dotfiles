FEATURES
========

. completion for almost anything via zsh
. icon shows running background processes
. history-substring-search
. fasd (and tab completion for it)
. powerline theme for vim
. shows git status in prompt
. shows active python virtual env
. shows error codes from failed commands

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

This theme was inspired by PowerlinePlain (https://github.com/Bash-it/bash-it/blob/master/themes/powerline-plain/powerline-plain.theme.bash) and based on BulletTrain (https://github.com/caiogondim/bullet-train-oh-my-zsh-theme).

In the misc folder you can find the Powerline patched SourceCode font and my currently used Sundried.itermcolors.

