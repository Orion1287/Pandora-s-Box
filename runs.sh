#!/bin/bash

# Print the logo
print_logo() {
    cat << "EOF"


  _____                _                 _       ____
 |  __ \              | |               ( )     |  _ \
 | |__) |_ _ _ __   __| | ___  _ __ __ _|/ ___  | |_) | _____  __
 |  ___/ _` | '_ \ / _` |/ _ \| '__/ _` | / __| |  _ < / _ \ \/ /
 | |  | (_| | | | | (_| | (_) | | | (_| | \__ \ | |_) | (_) >  <
 |_|   \__,_|_| |_|\__,_|\___/|_|  \__,_| |___/ |____/ \___/_/\_\




EOF
}

# Clear screen and show logo
clear
print_logo

#Exit on any error
#set -e

# Source utility functions
source ./utilities/utils.sh


source ./utilities/packages.conf

echo "Starting system setup..."

# Update the system first
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install yay AUR helper if not present
if ! command -v yay &> /dev/null; then
  echo "Installing yay AUR helper..."
  sudo pacman -S --needed git base-devel --noconfirm
  git clone https://aur.archlinux.org/yay.git
  cd yay
  echo "building yay"
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
else
  echo "yay is already installed"
fi

# Install packages by category
echo "Installing system utilities..."
install_packages "${SYSTEM_UTILS[@]}"

echo "Installing development tools..."
install_packages "${DEV_TOOLS[@]}"

echo "Installing fonts..."
install_packages "${FONTS[@]}"
# Some programs just run better as flatpaks. Like discord/spotify
echo "Installing flatpaks (like discord and spotify)"
./utilities/install-flatpaks.sh

#echo "Setting up ZSH"
#./utilities/zsh
#./utilities/zsh

#   echo "SSH"
#source ./utilities/ssh.sh restore
echo "Setting up git"
./utilities/git
#./utilities/git
rm ~/.zshrc
echo "Copying Configuration"
./utilities/dotfiles.sh
#./utilities/dev-env

#echo "Setting up DWM"
#source ~/pandoras-box/utilities/dwm.sh
#./utilities/dwm


echo "Setup complete! You may want to reboot your system."
