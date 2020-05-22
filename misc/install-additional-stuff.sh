echo "\n\nDo you also want to install additional app? [y/N] "
read -r -q response
if [[ "$response" == "n" ]]
then
    exit 0
fi

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

