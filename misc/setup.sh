#!/usr/bin/env bash
set -e

######################
# Configuration
######################
GHAR=${REMOTE:-git://github.com/philips/ghar.git}
DOTFILES=${REMOTE:-git@github.com:kakulukia/dotfiles.git}
green() {
  echo ""
  echo -e "\033[0;32m$1\033[0m"
}


##############################
# 1. Detect OS / PackageMgr
##############################
detect_os() {
  if command -v apt-get &>/dev/null; then
    INSTALL="sudo apt-get -y install"
  elif command -v yum &>/dev/null; then
    INSTALL="sudo yum -y install"
  elif command -v brew &>/dev/null; then
    INSTALL="brew install"
  else
    echo "Unsupported OS; please install dependencies manually." >&2
    exit 1
  fi
  echo "Using installer: $INSTALL"
}
green "Detecting OS and package manager.."
detect_os

##############################
# 2. Clone the dotfiles repo
##############################
green "Cloning the repo .."
cd
git clone https://github.com/philips/ghar.git
cd ghar
git clone --recursive https://github.com/kakulukia/dotfiles.git

##############################
# 2. Bootstrap: uv & Python
##############################
if ! command -v uv &>/dev/null; then
  green "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh >/dev/null
  export PATH="$HOME/.local/bin:$PATH"
fi
#green "Installing Python (3.13) via uv.."
#uv python install 3.13 --default --preview

##############################
# 3. Core Tools
##############################
## Ensure Rust toolchain (rustup & cargo)
#if ! command -v rustup >/dev/null 2>&1; then
#  green "Installing rustup (Rust toolchain manager) and cargo-binary installer...."
#  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -q >/dev/null 2>&1
#  # Load cargo environment
#  source "$HOME/.cargo/env"
#  curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash >/dev/null 2>&1
#fi
#
#if ! command -v gcc >/dev/null 2>&1; then
#  green "Installing build-essential to be able to compile tools.."
#  $INSTALL build-essential >/dev/null 2>&1
#fi

#green "Ensuring Starship is installed..."
if ! command -v starship >/dev/null 2>&1; then
  curl -fsSL https://starship.rs/install.sh | sh -s -- -y >/dev/null 2>&1
fi

# Install fzf if not already installed
if [ ! -d "$HOME/.fzf" ]; then
  green "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  ~/.fzf/install --bin --no-key-bindings --no-completion --no-update-rc
fi

##############################
## 4. Interactive tool selection
##############################
green "Select optional tools to install.."
# get path of this file without the file name
script_path=$(dirname "$(realpath "$0")")
$script_path/select_tools.py

##############################
# 5. Dotfiles Linking (Ghar) & Config Directory Sync
##############################
green "Linking dotfiles via ghar.."
rm "$HOME/.zshrc"
python "$HOME/ghar/bin/ghar" install

green "Linking additional configs.."
mkdir -p "$HOME/.config"
for d in "$script_path/.config"/*; do
  echo "Linking $d to $HOME/.config/$(basename "$d")"
  ln -sf "$d" "$HOME/.config/$(basename "$d")"
done
# Install xterm-ghostty terminfo if not available
if ! infocmp -x xterm-ghostty &>/dev/null; then
  green "Installing xterm-ghostty terminfo from dotfiles..."
  tic -x "$HOME/ghar/dotfiles/misc/xterm-ghostty.terminfo"
fi

##############################
# 6. Finalization
##############################
green "Changing default login shell to zsh.."
chsh -s "$(which zsh)" "$(whoami)"

green "Installation complete. Have fun with your new shell!"
echo "Type 'zsh' to start it or simply log out and back in."
