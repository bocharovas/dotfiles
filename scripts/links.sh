#!/bin/bash

echo "=== Проверяем и создаём симлинки ==="

declare -A links=(
  ["/home/duduk/.pgpass"]="/home/duduk/dotfiles/files-crypt/pgpass"
  ["/home/duduk/.config/nvim/init.lua"]="/home/duduk/dotfiles/files/lua/init.lua"
  ["/home/duduk/.config/nvim/lua/autocmds.lua"]="/home/duduk/dotfiles/files/lua/autocmds.lua"
  ["/home/duduk/.config/nvim/lua/options.lua"]="/home/duduk/dotfiles/files/lua/options.lua"
  ["/home/duduk/.config/gh/config.yml"]="/home/duduk/dotfiles/files/config.yml"
  ["/home/duduk/.config/xfce4/xfce4-session.xml"]="/home/duduk/dotfiles/files/xfce4-session.xml"
  ["/home/duduk/.gitconfig"]="/home/duduk/dotfiles/files/gitconfig"
  ["/home/duduk/.bashrc"]="/home/duduk/dotfiles/files/bashrc"
  ["/home/duduk/.bash_aliases"]="/home/duduk/dotfiles/files-crypt/bash_aliases"
  ["/home/duduk/.taskrc"]="/home/duduk/dotfiles/files/taskrc"
  ["/home/duduk/.gnupg/gpg.conf"]="/home/duduk/dotfiles/files-crypt/gpg.conf"
  ["/home/duduk/.gnupg/gpg-agent.conf"]="/home/duduk/dotfiles/files/gpg-agent.conf"
  ["/home/duduk/.gnupg/dirmngr.conf"]="/home/duduk/dotfiles/files-crypt/dirmngr.conf"
)

for link in "${!links[@]}"; do
  target="${links[$link]}"

  if [ -L "$link" ]; then
    echo "✔️  Симлинк уже существует: $link"
  elif [ -e "$link" ]; then
    echo "⚠️  Файл существует и не является симлинком: $link (пропускаю)"
  else
    echo "➕ Создаю симлинк: $link -> $target"
    mkdir -p "$(dirname "$link")"
    ln -s "$target" "$link"
  fi
done

echo "✅ Симлинки проверены и созданы, если необходимо."

