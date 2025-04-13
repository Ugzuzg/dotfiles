ZFUNCDIR=${ZDOTDIR:-$HOME}/functions
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(D@:t)

if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# setopt extended_glob

#PROMPT='$(kube_ps1)'$PROMPT

compdef _pacman paru=pacman

# auto rehash on completion
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' gain-privileges 1

if (( $+commands[fnm] )); then
  eval "`fnm env --use-on-cd`"
fi

if (( $+commands[jj] )); then
  source <(jj util completion zsh)
fi


eval "$(zellij setup --generate-auto-start zsh)"

for _rc in ${ZDOTDIR:-$HOME}/zshrc.d/*.zsh; do
  # Ignore tilde files.
  if [[ $_rc:t != '~'* ]]; then
    source "$_rc"
  fi
done
unset _rc
