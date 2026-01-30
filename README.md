# Personal Dotfiles

My personal configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

- **nvim** - Neovim configuration
- **tmux** - Tmux configuration
- **zsh** - Zsh shell configuration
- **git** - Git configuration

## Installation

```sh
# Clone the repo
git clone <your-github-url> ~/personal-dotfiles

# Install stow if needed
brew install stow  # or: sudo apt install stow

# Stow the packages you want
cd ~/personal-dotfiles
stow nvim tmux zsh git
```

## Usage

Stow creates symlinks from this repo to your home directory:
- `nvim/.config/nvim` → `~/.config/nvim`
- `tmux/.tmux.conf` → `~/.tmux.conf`
- `zsh/.zshrc` → `~/.zshrc`
- `git/.gitconfig` → `~/.gitconfig`

To update configs, edit files in this repo and changes appear immediately.

## Work dotfiles

For work-specific configs (Amazon tools, etc.), see my separate work dotfiles repo.
