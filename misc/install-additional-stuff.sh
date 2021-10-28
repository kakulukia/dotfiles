#!/usr/bin/env zsh
echo "\n\nDo you also want to install additional apps? [y/N] "
read -r -q response
if [ "$response" != "y" ]
then
    exit 0
fi

apt=$(command -v snap)
apt=$(command -v apt-get)
yum=$(command -v yum)
brew=$(command -v brew)

## Detect the systems installer
if [ -n "$apt" ]; then
    echo "some of the packages might not be installable if not using osx\n\n"
    INSTALL='apt install -y'
    if [ $EUID -ne 0 ]; then
       INSTALL='sudo '$INSTALL
    fi
    eval "$INSTALL" build-essential
    # Python dependencies
    eval "$INSTALL" build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl libjpeg-dev zlib1g-dev
elif [ -n "$yum" ]; then
    echo "some of the packages might not be installable if not using osx\n\n"
    INSTALL='yum install -y'
    if [ $EUID -ne 0 ]; then
       INSTALL='sudo '$INSTALL
    fi
elif [ -n "$brew" ]; then
    INSTALL='brew install'
else
    echo "Error: Your OS is not supported - please install the tools manually :(" >&2;
    exit 1;
fi

cat essentials.txt | xargs -L 1 -I {} zsh -c "$INSTALL {}"

echo "\n\ninstalling even more additional packages .."
zsh extras.sh
