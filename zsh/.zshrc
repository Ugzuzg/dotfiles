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

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zaw

antigen theme wezm+

antigen apply

# setopt extended_glob

alias ip='ip --color'
alias diff='diff --color=auto'
alias cat='bat'
alias ls='eza'
#alias cd='z'

export GPG_TTY=$(tty)

compdef _pacman yay=pacman
compdef _pacman paru=pacman

# auto rehash on completion
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' gain-privileges 1

if command -v fnm &> /dev/null ; then
  eval "`fnm env --use-on-cd`"
fi
eval "$(zoxide init zsh)"

if command -v kubectl &> /dev/null ; then
  source <(kubectl completion zsh)
fi

if command -v helm &> /dev/null ; then
  source <(helm completion zsh)
fi

eval "$(zellij setup --generate-auto-start zsh)"
