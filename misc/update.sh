lastCD=`pwd`

cd
cd ghar/dotfiles

echo "\nupdating dotfiles .."
git pull
git submodule update --init --recursive

echo "\n\ninstalling additional system packages .."
apt=`command -v apt-get`
yum=`command -v yum`
brew=`command -v brew`

## Detect the systems installer
if [ -n "$apt" ]; then
    echo "some of the packages might not be installable if not using osx"
    INSTALL='sudo apt -y install'
elif [ -n "$yum" ]; then
    echo "some of the packages might not be installable if not using osx"
    INSTALL='sudo yum -y install'
elif [ -n "$brew" ]; then
    INSTALL='brew install'
else
    echo "Error: You OS is not supported :(" >&2;
    exit 1;
fi

$INSTALL $(cat misc/essentials.txt)

echo "\n\ninstalling even more additional packages .."
misc/additional-stuff.sh

