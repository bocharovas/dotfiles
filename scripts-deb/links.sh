#!/bin/bash

echo "=== überprüfe und erstelle Symlinks ==="

DOTFILES="$HOME/projects/dotfiles"

declare -A links=(
  ["$HOME/.pgpass"]="$DOTFILES/files-crypt/pgpass"
  ["$HOME/.config/nvim/init.lua"]="$DOTFILES/files/lua/init.lua"
  ["$HOME/.config/nvim/lua/config/autocmds.lua"]="$DOTFILES/files/lua/autocmds.lua"
  ["$HOME/.config/nvim/lua/config/options.lua"]="$DOTFILES/files/lua/options.lua"
  ["$HOME/.config/gh/config.yml"]="$DOTFILES/files/config.yml"
  ["$HOME/.config/xfce4/xfce4-session.xml"]="$DOTFILES/files/xfce4-session.xml"
  # ["$HOME/.gitconfig"]="$DOTFILES/files/gitconfig"
  ["$HOME/.bashrc"]="$DOTFILES/files/bashrc"
  ["$HOME/.bash_aliases"]="$DOTFILES/files-crypt/bash_aliases"
  ["$HOME/.taskrc"]="$DOTFILES/files/taskrc"
  ["$HOME/.gnupg/gpg.conf"]="$DOTFILES/files-crypt/gpg.conf"
  ["$HOME/.gnupg/gpg-agent.conf"]="$DOTFILES/files/gpg-agent.conf"
  ["$HOME/.gnupg/dirmngr.conf"]="$DOTFILES/files-crypt/dirmngr.conf"
)

for link in "${!links[@]}"; do
  target="${links[$link]}"

  if [ -L "$link" ]; then
    echo "der Symlink existiert bereits: $link"
  elif [ -e "$link" ]; then
    echo "die Datei existiert und ist kein Symlink: $link (überspringe)"
  else
    echo "der Symlink wird erstellt: $link -> $target"
    mkdir -p "$(dirname "$link")"
    ln -s "$target" "$link"
  fi
done

echo "fertig"

