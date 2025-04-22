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
red() {
  echo -e "\033[0;31m$1\033[0m"
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
green "Detecting OS and package manager..."
detect_os

##############################
# 2. Bootstrap: uv & Python
##############################
if ! command -v uv &>/dev/null; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.local/bin:$PATH"
fi
green "Installing Python (3.13) via uv..."
uv python install 3.13 --default --preview

##############################
# 3. Core Tools (via apps.yaml)
##############################
# Install Rust-based tools via binstall
# Ensure Rust toolchain (rustup & cargo)
#if ! command -v rustup >/dev/null 2>&1; then
#  green "Installing rustup (Rust toolchain manager)..."
#  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
#  # Load cargo environment
#  source "$HOME/.cargo/env"
#fi
#green "Ensuring Starship is installed..."
#if ! command -v starship >/dev/null 2>&1; then
#  curl -fsSL https://starship.rs/install.sh | sh -s -- -y >/dev/null 2>&1
#fi

# Install fzf if not already installed
if [ ! -d "$HOME/.fzf" ]; then
  green "Installing fzf..."
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
fi

# Placeholder: install_from_yaml apps.yaml
# e.g. uv tool install-from apps.yaml

##############################
# 4. Dotfiles Linking (Ghar)
##############################
echo "Linking dotfiles via ghar..."
python "$HOME/ghar/bin/ghar" install

##############################
# 5. Config Directory Sync
##############################
echo "Linking additional configs..."
mkdir -p "$HOME/.config"
for d in "$(pwd)/misc/.config"/*; do
  ln -sf "$d" "$HOME/.config/$(basename "$d")"
done

##############################
# 6. Optional Tools
##############################
# Placeholder for interactive apps.yaml logic
# echo "Installing optional tools..."
# uv tool install-from apps.yaml

##############################
# 7. Finalization
##############################
green "Changing default login shell to zsh..."
chsh -s "$(which zsh)" "$(whoami)"
#  Change default login shell to zsh
# if [ $EUID -ne 0 ]; then
#   sudo chsh -s "$(which zsh)" "$(whoami)"
# else
#   chsh -s "$(which zsh)" "$(whoami)"
# fi

green "Installation complete. Have fun with your new shell!"
echo "Type 'zsh' to start it or simply log out and back in."
