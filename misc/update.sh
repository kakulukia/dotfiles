#!/usr/bin/env node
lastCD=`pwd`

cd
cd ghar/dotfiles
git fetch

git_status="$(git status -b --porcelain > /dev/null)"
behind_re='.+behind ([0-9]+).+'

if [[ "${git_status}" =~ ${behind_re} ]] ; then
    echo "\nupdating dotfiles .."
else
    echo "You are up to date."
    echo ""
    exit
fi

git pull
git submodule update --init --recursive

echo "\n\nrefreshing dotfiles links .."
python3 ../bin/ghar install

echo "\n\ninstalling additional system packages .."
apt=`command -v apt-get`
yum=`command -v yum`
brew=`command -v brew`

## Detect the systems installer
if [ -n "$apt" ]; then
    echo "some of the packages might not be installable if not using osx\n\n"
    INSTALL='sudo apt -y install'
elif [ -n "$yum" ]; then
    echo "some of the packages might not be installable if not using osx\n\n"
    INSTALL='sudo yum -y install'
elif [ -n "$brew" ]; then
    INSTALL='brew install'
else
    echo "Error: Your OS is not supported :(" >&2;
    exit 1;
fi

$INSTALL $(cat misc/essentials.txt)

echo "\n\ninstalling even more additional packages .."
misc/additional-stuff.sh

mkdir -p ~/.config/colorls
path=`pwd`
ln -s $path/misc/dark_colors.yaml ~/.config/colorls/
