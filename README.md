FEATURES
========

![Preview](http://raw.github.com/kakulukia/dotfiles/master/misc/img/preview.png)

Features in this screen shot:

  * icon shows running background processes
  * fasd (and tab completion for it)
  * shows git status in prompt
  * shows active python virtual env
  * different prompt when connected via ssh or as root
  * some handy aliases
  * completion for almost anything via zsh
  * shows errors (and optional codes) from failed commands
  * history-substring-search
  
Also inculded is some basic vim config and a powerline theme for vim.

install ZSH
===========

    apt-get/brew install zsh git

Settings ZSH as the default shell.
    
    chsh -s /usr/bin/zsh

install this dotfiles repo 
==========================

    cd
    git clone https://github.com/philips/ghar.git
    cd ghar
    git clone --recursive git://github.com/kakulukia/dotfiles.git andy
    bin/ghar install
    
Additional installation steps:

    sudo apt-get install -y python-pip python-dev
    sudo pip install psutil thefuck virtualenvwrapper

This theme was inspired by PowerlinePlain (https://github.com/Bash-it/bash-it/blob/master/themes/powerline-plain/powerline-plain.theme.bash) and based on BulletTrain (https://github.com/caiogondim/bullet-train-oh-my-zsh-theme).

In the misc folder you can find the Powerline patched SourceCode font and my currently used Sundried.itermcolors.

