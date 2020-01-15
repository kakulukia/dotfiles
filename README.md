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
* custom tmux config using ctrl+space as activator shortcut
  
Also included is some basic SpaceVim config and a powerline theme for tmux.

Installation
==============

Be sure you are logged in as the user for whom you want to install this shell pakage and that the user has sudo rights.

    curl https://raw.githubusercontent.com/kakulukia/dotfiles/master/misc/setup.sh | sh


This will install the following:

* GIT to be able to download the repo itself
* ZSH as your new default shell
* oh my zsh
* ghar for managing the dotfiles itself (links everything into your home folder)
* SpaceVim
* fasd
* some handy aliases
  
Note: Use the `~/.gitconfig-personal` file to set your git username. That file is imported in `.gitconfig` so that settings can be ported via this repo, but the username stays personal.

In the misc folder you can find:

* the Powerline patched SourceCode font (use that for your console to not see weird characters in the terminal - or any other [Nerdfont](https://www.nerdfonts.com/))
* my currently used Sundried.itermcolors
* better-osx-settings script
* an opinionated set of tools ([these](https://github.com/kakulukia/dotfiles/blob/master/misc/essentials.txt) and [those](https://github.com/kakulukia/dotfiles/blob/master/misc/additional-stuff.sh))
* customized `dark_colors.yaml` for colorls, which goes into `~/.config/colorls/`

The dotfiles can be updated with the `update-dotfiles` alias.

Disclaimer
===========

This theme was inspired by PowerlinePlain (https://github.com/Bash-it/bash-it/blob/master/themes/powerline-plain/powerline-plain.theme.bash) and based on BulletTrain (https://github.com/caiogondim/bullet-train-oh-my-zsh-theme).

