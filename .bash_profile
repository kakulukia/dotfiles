# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# the rest of this file is commented out.

# set PATH so it includes user's private bin if it exists
#if [ -d ~/bin ] ; then
#    PATH=.:~/bin:"${PATH}"
#fi

# do the same with MANPATH
#if [ -d ~/man ]; then
#    MANPATH=~/man${MANPATH:-:}
#    export MANPATH
#fi

source .profile

# ignore identical lines next to each other
export HISTCONTROL=ignoreboth

# Change this to a reasonable number of lines to save, I like to save only 100.
export HISTSIZE=17777
export INPUTRC=~/.inputrc
