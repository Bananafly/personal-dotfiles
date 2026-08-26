# Personal Dotfiles

Configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/). Works on Mac and Linux.

## Packages

| Package | What it symlinks |
|---------|-----------------|
| `claude` | `~/.claude/CLAUDE.md`, `~/.claude/rules/*.md`, `~/.claude/skills/*/` |
| `nvim` | `~/.config/nvim/` |
| `tmux` | `~/.tmux.conf` |
| `zsh` | `~/.zshrc` |
| `git` | `~/.gitconfig` |

## Claude skills

`claude/.claude/skills/` holds skills that apply on every machine. `anki-card` is written here. The rest are vendored copies of third-party skills, with local edits, so they need a manual re-pull to update.

| Skill(s) | Upstream | Local edits |
|---|---|---|
| `anki-card` | written here | n/a |
| `unslop`, `deslop`, `interrogate`, `swarm`, `blast-radius`, `what-did-i-get-done`, `principle-*` | [pstack](https://github.com/michael-denyer/pstack-claude) (MIT), a Claude Code port of `cursor/plugins/pstack` | none, upstream verbatim |
| `handoff` | [mattpocock/skills](https://github.com/mattpocock/skills) | writes to `~/.claude/handoffs/` instead of `$TMPDIR`, which macOS reaps between boots |
| `grilling` | [mattpocock/skills](https://github.com/mattpocock/skills) | emoji stripped from the round format; `disable-model-invocation: true` added so it can't fire unprompted |
| `teach` | [mattpocock/skills](https://github.com/mattpocock/skills) | refuses to scaffold into `$HOME`, a repo, or a Brazil workspace; uses `~/learning/<topic>/` instead |

Notes:

- The `principle-*` skills and `unslop` are model-invoked, not user-invoked: they fire on their trigger conditions rather than being typed. `handoff`, `grilling`, and `teach` are the reverse, invoked by name.
- `blast-radius` references pstack's `why` skill, which is not installed here (it depends on `gh`, which is absent on the work laptop). It degrades to doing its own git anchoring.
- `interrogate` and pstack's platform notes link to `../poteto-mode/references/codex-tools.md`, which is not installed. Only relevant on non-Claude runtimes.
- `principle-never-block-on-the-human` deliberately replaces the "if you're stuck or unsure, stop and ask" line that used to be in `CLAUDE.md`. Its own Boundaries section still requires confirmation for irreversible actions.

## Setup (Mac or any new machine)

```sh
git clone <repo-url> ~/personal-dotfiles
cd ~/personal-dotfiles
brew install stow  # or: sudo apt install stow

# Remove existing files that would conflict
rm -f ~/.zshrc ~/.tmux.conf ~/.gitconfig

stow claude zsh tmux nvim git
```

If Claude Code has already run on the machine, `~/.claude/` may hold its own `CLAUDE.md` or skills, and `stow claude` will abort with "existing target is not owned by stow". Symlinks that already point into this repo are safe to delete before re-stowing; real files are not, so move those aside and merge them by hand.

## Post-stow setup

### tmux plugins

tmux config uses [TPM](https://github.com/tmux-plugins/tpm) for plugin management. After stowing:

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Then in tmux: prefix + I (capital I) to install plugins
# Or non-interactively:
~/.tmux/plugins/tpm/bin/install_plugins
```

## How it works

Stow creates symlinks from this repo into your home directory. Edits to repo files take effect immediately — no re-stow needed.

Re-run `stow <package>` only when you add new files to a package.

## Work machine

On an Amazon dev desktop, also clone and stow [work-dotfiles](https://code.amazon.com/packages/DotFiles-kreidema) which adds Amazon-specific shell config and Claude Code rules. The `.zshrc` here sources `~/.zshrc-work.zsh` if it exists.
