FEATURES
========

![MacOS](https://github.com/kakulukia/dotfiles/workflows/MacOS/badge.svg)
![Ubuntu](https://github.com/kakulukia/dotfiles/workflows/Ubuntu/badge.svg)

![Preview](http://raw.github.com/kakulukia/dotfiles/master/misc/img/preview.png)

Installation
--------------

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
------------

This theme was inspired by PowerlinePlain (<https://github.com/Bash-it/bash-it/blob/master/themes/powerline-plain/powerline-plain.theme.bash>) and based on BulletTrain (<https://github.com/caiogondim/bullet-train-oh-my-zsh-theme>).
