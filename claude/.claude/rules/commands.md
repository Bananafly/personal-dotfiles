Avoid commands that require user interaction or pagers.

- `git --no-pager diff`, `git --no-pager log`, `git --no-pager show`
- `PAGER= gh ...` for GitHub CLI
- Never use `-i` flags (interactive mode)
