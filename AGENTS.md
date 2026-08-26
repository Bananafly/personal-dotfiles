# Working in this repo

Instructions for agents editing this dotfiles repo. This is *not* the global instruction file: the global one is `claude/.claude/CLAUDE.md`, which stow links to `~/.claude/CLAUDE.md`.

## Two agents, one source of truth

Claude Code and Codex read different files. Everything here is arranged so nothing is maintained twice.

| Thing | Canonical location | How the other agent gets it |
|---|---|---|
| Global instructions | `claude/.claude/CLAUDE.md` | flattened into `codex/.codex/AGENTS.md` |
| Rules | `claude/.claude/rules/*.md` | flattened into `codex/.codex/AGENTS.md` |
| Skills | `claude/.claude/skills/<name>/` | `~/.codex/skills/<name>` symlinks to the same folder |

## Never edit these

- **`codex/.codex/AGENTS.md` is generated.** Edit `claude/.claude/CLAUDE.md` or a file in `claude/.claude/rules/` instead, then run `bin/build-codex-agents.sh`. The `githooks/pre-commit` hook does this for you on commit, but only if `core.hooksPath` is set (see README).
- **`~/.codex/AGENTS.md` is a symlink to that generated file.** If you are running under Codex, this is the instruction file you were given, and editing it is a dead end: your change is discarded on the next regeneration. Go to the Claude source.

## Adding a skill

Skills live in `claude/.claude/skills/<name>/SKILL.md` and use the same format for both agents. After adding one, relink both:

```sh
stow claude
stow -d ~/personal-dotfiles/claude/.claude -t ~/.codex/skills skills
```

Skills vendored from upstream repos are listed in the README with their provenance and any local edits. Keep that table current, and keep local edits minimal so upstream can still be diffed.

Note that `disable-model-invocation` is honoured by Claude Code only. Codex lists every skill it finds, so a skill gated for Claude can still fire on its own under Codex.

## Do not put Amazon-internal content here

This repo pushes to GitHub. Amazon-internal rules, package names, service internals, and ticket contents belong in `work-dotfiles` instead. The work rules are deliberately excluded from the generated `AGENTS.md` for this reason.
