#!/bin/bash

# === CONFIG ===
KEY_NAME="id_ed25519"
BACKUP_DIR="$HOME/ssh-key-backup"
ENCRYPT=true      # Set to false if you don't want encryption
GPG_RECIPIENT="ranveerkalbagg@gmail.com"  # Your GPG key/email

# === FUNCTIONS ===

backup_key() {
    echo "[*] Backing up SSH key..."

    mkdir -p "$BACKUP_DIR"

    cp "$HOME/.ssh/$KEY_NAME" "$BACKUP_DIR/"
    cp "$HOME/.ssh/$KEY_NAME.pub" "$BACKUP_DIR/"

    if $ENCRYPT; then
        echo "[*] Encrypting private key with GPG..."
        gpg -o "$BACKUP_DIR/$KEY_NAME.gpg" --encrypt --recipient "$GPG_RECIPIENT" "$BACKUP_DIR/$KEY_NAME"
        shred -u "$BACKUP_DIR/$KEY_NAME"
    fi

    echo "[✔] SSH key backed up to $BACKUP_DIR"
}

restore_key() {
    echo "[*] Restoring SSH key..."

    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"

    if [ -f "$BACKUP_DIR/$KEY_NAME.gpg" ]; then
        echo "[*] Decrypting SSH key..."
        gpg -o "$HOME/.ssh/$KEY_NAME" --decrypt "$BACKUP_DIR/$KEY_NAME.gpg"
    else
        cp "$BACKUP_DIR/$KEY_NAME" "$HOME/.ssh/"
    fi

    cp "$BACKUP_DIR/$KEY_NAME.pub" "$HOME/.ssh/"
    chmod 600 "$HOME/.ssh/$KEY_NAME"
    chmod 644 "$HOME/.ssh/$KEY_NAME.pub"

    eval "$(ssh-agent -s)"
    ssh-add "$HOME/.ssh/$KEY_NAME"

    echo "[✔] SSH key restored and added to agent"
}

show_help() {
    echo "Usage: $0 [backup|restore]"
}

# === MAIN ===

case "$1" in
    backup) backup_key ;;
    restore) restore_key ;;
    *) show_help ;;
esac

