#!/bin/bash

ORIGINAL_DIR=$(pwd)
REPO_URL="https://github.com/Orion1287/dotfiles"
REPO_NAME="dotfiles"
SDDM_REPO="https://github.com/Orion1287/windows11sddm.git"
SDDM_REPO_NAME="windows11sddm"


is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

cd ~

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL"
fi
# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$SDDM_REPO_NAME' already exists. Skipping clone"
else
  git clone "$SDDM_REPO"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  cd "$REPO_NAME"
  sudo mv sddm.conf /etc/
  #stow zsh
  stow ags
  stow hyprland
  stow xinitrc
  stow dev-commit
  stow zsh
  stow ghostty
  stow nvim
  stow tmux
  stow tmux-sessionizer
  stow bat
  stow gtk-4.0
  stow wallpapers
  #stow zsh-profile
else
  echo "Failed to clone the repository."
  exit 1
fi


cd ../"$SDDM_REPO_NAME"
./install.sh
