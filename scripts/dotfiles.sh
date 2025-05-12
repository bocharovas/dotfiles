#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 {install|update|backup|link}"
  exit 1
}

install() {
  echo "Running install..."

  if ! command -v git-crypt &> /dev/null; then
	    echo "git-crypt is not installed. Installing git-crypt..."
	    sudo apt update
	    sudo apt install -y git-crypt
  else
	   echo "git-crypt is already installed."	
  fi

  if git-crypt unlock; then
	    echo "git-crypt unlock successful: files are now decrypted."
  else
	    echo "git-crypt unlock failed. Make sure you have the correct GPG key."
	    exit 1
  fi

   # Проверка наличия pnpm
  if ! command -v pnpm &> /dev/null; then
    echo "pnpm is not installed."

    # Установка через corepack, если он есть
    if command -v corepack &> /dev/null; then
      echo "Using corepack to install pnpm..."
      corepack enable
      corepack prepare pnpm@latest --activate
    else
      echo "corepack is not available. Please install pnpm manually: https://pnpm.io/installation"
      exit 1
    fi
  else
    echo "pnpm is already installed."
  fi

  # Установка зависимостей через pnpm
  if [ -f "package.json" ]; then
    echo "Running pnpm install..."
    pnpm install
  else
    echo "No package.json found. Skipping pnpm install."
  fi

  echo "Installation complete!"
}

update() {
  echo "Running update..."
  git pull
}

backup() {
  echo "Running backup..."
  git add .
  git commit -m "Backup on $(date)"
  git push
}

link() {
  echo "Linking dotfiles..."
  ln -sf "$PWD/.gitconfig" "$HOME/.gitconfig"
  ln -sf "$PWD/.tmux.conf" "$HOME/.tmux.conf"
  # Add other dotfiles here
}

[[ $# -eq 0 ]] && usage

case "$1" in
  install) install ;;
  update)  update ;;
  backup)  backup ;;
  link)    link ;;
  *)       usage ;;
esac
