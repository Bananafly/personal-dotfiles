# Personal Dotfiles

Configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/). Works on Mac and Linux.

## Packages

| Package | What it symlinks |
|---------|-----------------|
| `claude` | `~/.claude/CLAUDE.md`, `~/.claude/rules/{exploration,commands,investigation}.md` |
| `nvim` | `~/.config/nvim/` |
| `tmux` | `~/.tmux.conf` |
| `zsh` | `~/.zshrc` |
| `git` | `~/.gitconfig` |

## Setup (Mac or any new machine)

```sh
git clone <repo-url> ~/personal-dotfiles
cd ~/personal-dotfiles
brew install stow  # or: sudo apt install stow

# Remove existing files that would conflict
rm -f ~/.zshrc ~/.tmux.conf ~/.gitconfig

stow claude zsh tmux nvim git
```

## How it works

Stow creates symlinks from this repo into your home directory. Edits to repo files take effect immediately — no re-stow needed.

Re-run `stow <package>` only when you add new files to a package.

## Work machine

On an Amazon dev desktop, also clone and stow [work-dotfiles](https://code.amazon.com/packages/DotFiles-kreidema) which adds Amazon-specific shell config and Claude Code rules. The `.zshrc` here sources `~/.zshrc-work.zsh` if it exists.
