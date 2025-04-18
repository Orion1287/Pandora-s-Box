#!/usr/bin/env bash

# Install necessary dependencies
sudo pacman -Sy --noconfirm base-devel xorg xorg-xinit libx11 libxft libxinerama

DWM_DIR="$HOME/dwm"
REPO_URL="https://github.com/Orion1287/dwm.git"  # Use SSH instead of HTTPS

# Remove old directory if invalid
if [ -d "$DWM_DIR" ] && [ ! -d "$DWM_DIR/dwm" ]; then
    echo "Removing invalid DWM directory."
    rm -rf "$DWM_DIR"
fi

# Clone or pull latest changes
if [ ! -d "$DWM_DIR" ]; then
    git clone "$REPO_URL" "$DWM_DIR"
else
    echo "DWM directory exists. Pulling latest changes..."
    cd "$DWM_DIR" && git pull
fi

# Apply patches (if any exist)
PATCH_DIR="$DWM_DIR/patches"
if [ -d "$PATCH_DIR" ]; then
    echo "Applying patches..."
    cd "$DWM_DIR/dwm" || exit 1

    for patch in "$PATCH_DIR"/*.patch "$PATCH_DIR"/*.diff; do
        [ -e "$patch" ] || continue
        echo "Applying patch: $patch"
        if patch -p1 < "$patch"; then
            echo "Successfully applied: $patch"
        else
            echo "Failed to apply: $patch"
            exit 1
        fi
    done
else
    echo "No patches found. Skipping patching step."
fi

# Build and install dwm
echo "Building and installing dwm..."
cd "$DWM_DIR/dwm" || exit 1
sudo make clean install
cd "$DWM_DIR/slstatus" || exit 1 
sudo make clean install

