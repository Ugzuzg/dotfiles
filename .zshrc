source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh

antigen bundle git

antigen bundle pep8
antigen bundle pip

antigen bundle adb

antigen bundle archlinux

antigen bundle node
antigen bundle npm
antigen bundle yarn
antigen bundle rvm

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zaw

antigen theme wezm+

antigen apply

# setopt extended_glob

alias ip='ip --color'
alias diff='diff --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export GPG_TTY=$(tty)

compdef _pacman yay=pacman

# auto rehash on completion
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' gain-privileges 1

eval "`fnm env --use-on-cd`"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

