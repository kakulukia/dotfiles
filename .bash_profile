#!/usr/bin/env bash

# Path to the bash it configuration
export BASH_IT=$HOME/.bash_it

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='powerline-plain'

# Set my editor and git editor
export EDITOR="/usr/bin/vim"
export GIT_EDITOR='/usr/bin/vim'

export IRC_CLIENT='irssi'

# Load Bash It
source $BASH_IT/bash_it.sh

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Add tab completion for many Bash commands
if which brew > /dev/null && [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion";
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

# Thanks to @tmoitie, adds more tab completion for bash,
# also when hitting tab twice it will show a list.
if which brew > /dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

. ~/.alias

HISTFILESIZE=12345
export HISTCONTROL=ignoreboth:erasedups
export PATH=~/ghar/bin:~/bin:$PATH
export DJANGO_SETTINGS_MODULE=backend.settings.andy
source /usr/local/bin/virtualenvwrapper.sh

eval "$(fasd --init auto)"
export TERM='xterm-256color'
source ~/.profile
