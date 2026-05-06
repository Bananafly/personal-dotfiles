export PATH=$HOME/.local/bin:$HOME/bin:$PATH

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git tmux)
source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR='nvim'

# Aliases
alias e=emacs

# Functions
set-title() { echo -e "\e]0;$*\007" }
ssh() { set-title $*; /usr/bin/ssh -2 $*; set-title $HOST }

# Cargo
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# Mise (runtime management)
command -v mise &>/dev/null && eval "$(mise activate zsh)"
[[ -f ~/.local/share/mise/completions.zsh ]] && source ~/.local/share/mise/completions.zsh

# Completions
autoload -Uz compinit && compinit

# Prompt
export RPROMPT=

# Source work-specific config if it exists
[ -f ~/.zshrc-work.zsh ] && source ~/.zshrc-work.zsh
