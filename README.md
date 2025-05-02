# dotfiles

CLI tool for managing personal dotfiles across multiple machines.

This repository contains configuration files and a script to help automate setup, backup, and synchronization of dotfiles like `.gitconfig`, `.zshrc`, `.tmux.conf`, and more.

## Features

- Simple CLI interface (`./dotfiles`)
- Easily symlink configs into `$HOME`
- Backup configs from system into the repo
- Git-friendly structure
- Compatible with Linux

## Installation

```bash
git clone https://github.com/bocharovas/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./dotfiles install
```

You can also run individual commands:

```bash
./dotfiles link      # Create symlinks in $HOME
./dotfiles backup    # Save current configs into the repo
./dotfiles update    # Pull latest changes
```

## Encrypting Files with git-crypt

If you want to use encrypted files, such as `.pgpass`, with this repository, you need to install **git-crypt**:

### Installing `git-crypt`

- On **Ubuntu/Debian**:
  ```bash
  sudo apt-get install git-crypt

## Structure

```
dotfiles/
├── .gitconfig
├── .zshrc
├── .tmux.conf
├── nvim/
│   └── init.lua
├── install.sh
├── dotfiles        # CLI wrapper script
└── README.md
```

## Repository

[github.com/bocharovas/dotfiles](https://github.com/bocharovas/dotfiles)

## License

MIT — see [LICENSE](./LICENSE)
