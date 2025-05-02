#!/usr/bin/env bash
set -euox pipefail

usage() {
  echo "Usage: $0 {install|update|backup|link}"
  exit 1
}

install() {
  echo "Running install..."
  # Check if git-crypt is installed
  if ! command -v git-crypt &> /dev/null; then
    echo "git-crypt is not installed. Please install git-crypt before proceeding."
    echo "Use 'sudo apt-get install git-crypt' for Ubuntu/Debian or 'brew install git-crypt' for macOS."
    exit 1
  fi

  # Decrypt .pgpass
  if [[ -f "$PWD/.pgpass.gpg" ]]; then
    git-crypt unlock
    chmod 600 "$HOME/.pgpass"
    echo ".pgpass decrypted and installed"
  fi

  # Other actions
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
