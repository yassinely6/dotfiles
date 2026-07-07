#!/bin/sh

ORIGINAL_DIR=$(pwd)
REPO_URL="https://github.com/yassinely6/dotfiles.git"
REPO_NAME="dotfiles"

is_stow_installed() {
  pacman -Qi stow > /dev/null
}

if ! is_stow_installed; then
  echo "install stow first"
  exit 1
fi

cd ~

if [ -d "$REPO_NAME" ]; then
  echo "repository '$REPO_NAME' already exists. skipping clone :)"
else
  git clone "$REPO_URL" || {
    echo "failed to clone repository"
    exit 1
  }
fi

echo "applying dotfiles..."

cd "$REPO_NAME" || exit 1

# 🔥 REMOVE CONFLICTING FILE BEFORE STOW
rm -f ~/.config/hypr/hyprlock.conf  ~/.config/hypr/input.conf ~/.local/share/omarchy/bin/omarchy-system-lock
stow lock-time
stow hypr

cd "$ORIGINAL_DIR"
