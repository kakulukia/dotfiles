#!/usr/bin/env zsh
echo "\n\nDo you also want to install additional apps? [y/N] "
read -r -q response
if [[ "$response" != "y" ]]
then
    exit 0
fi

apt=`command -v snap`
apt=`command -v apt-get`
yum=`command -v yum`
brew=`command -v brew`

## Detect the systems installer
if [ -n "$apt" ]; then
    echo "some of the packages might not be installable if not using osx\n\n"
    INSTALL='sudo apt -y install'
elif [ -n "$apt" ]; then
    echo "some of the packages might not be installable if not using osx\n\n"
    INSTALL='sudo apt -y install'
elif [ -n "$yum" ]; then
    echo "some of the packages might not be installable if not using osx\n\n"
    INSTALL='sudo yum -y install'
elif [ -n "$brew" ]; then
    INSTALL='brew install'
else
    echo "Error: Your OS is not supported - please install the tools manually :(" >&2;
    exit 1;
fi

cat essentials.txt | xargs -L 1 -I {} zsh -c "$INSTALL {}"

echo "\n\ninstalling even more additional packages .."
zsh extras.sh
