source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh

antigen bundle git

antigen bundle pep8
antigen bundle pip

antigen bundle rails
antigen bundle ruby
antigen bundle rvm

antigen bundle adb

antigen bundle archlinux

antigen bundle node
antigen bundle npm
antigen bundle yarn

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen theme wezm+

antigen apply

# setopt extended_glob

alias ip='ip --color'
alias diff='diff --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export GPG_TTY=$(tty)
source /usr/share/nvm/init-nvm.sh

compdef _pacman bb-wrapper=pacman
compdef _pacman yay=pacman
