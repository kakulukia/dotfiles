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

Installation
==============

Be sure you are logged in as the user for whom you want to install this shell pakage and that the user has sudo rights.

    wget -O - https://raw.githubusercontent.com/kakulukia/dotfiles/master/misc/setup.sh | bash
    
This will install the following:

  - GIT to be able to download the repo itself
  - ZSH as your new default shell
  - oh my zsh
  - ghar for managing the dotfiles itself (links everythin into the home folder)
  - vim-colors-solarized
  - vim-airline
  - fasd

Disclaimer
===========

This theme was inspired by PowerlinePlain (https://github.com/Bash-it/bash-it/blob/master/themes/powerline-plain/powerline-plain.theme.bash) and based on BulletTrain (https://github.com/caiogondim/bullet-train-oh-my-zsh-theme).

In the misc folder you can find the Powerline patched SourceCode font and my currently used Sundried.itermcolors.

