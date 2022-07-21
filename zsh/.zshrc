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

autoload -U zmv

alias ip='ip --color'
alias diff='diff --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cat='bat'
alias ls='exa'
alias cd='z'

export GPG_TTY=$(tty)

# auto rehash on completion
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' gain-privileges 1

eval "`fnm env --use-on-cd`"
eval "$(zoxide init zsh)"

if command -v kubectl &> /dev/null ; then
  source <(kubectl completion zsh)
fi

if command -v helm &> /dev/null ; then
  source <(helm completion zsh)
fi

# check if in WSL
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
  # WSL2 gpg setup
  export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
  if ! ss -a | grep -q "$SSH_AUTH_SOCK"; then
    rm -f "$SSH_AUTH_SOCK"
    wsl2_ssh_pageant_bin="$HOME/.ssh/wsl2-ssh-pageant.exe"
    if test -x "$wsl2_ssh_pageant_bin"; then
      (setsid nohup socat UNIX-LISTEN:"$SSH_AUTH_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin" >/dev/null 2>&1 &)
    else
      echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
    fi
    unset wsl2_ssh_pageant_bin
  fi

  export GPG_AGENT_SOCK="/run/user/$UID/gnupg/S.gpg-agent"
  if (( $(ss -a | grep -E "$GPG_AGENT_SOCK\s" | wc -l) <= 1 )); then
    echo "setting up gpg agent"
    rm -rf "$GPG_AGENT_SOCK"
    wsl2_ssh_pageant_bin="$HOME/.ssh/wsl2-ssh-pageant.exe"
    config_path="C\:/Users/JVIKTORC/AppData/Local/gnupg"
    if test -x "$wsl2_ssh_pageant_bin"; then
      (setsid nohup socat UNIX-LISTEN:"$GPG_AGENT_SOCK,fork" EXEC:"$wsl2_ssh_pageant_bin --gpgConfigBasepath ${config_path} --gpg S.gpg-agent" >/dev/null 2>&1 &)
    else
      echo >&2 "WARNING: $wsl2_ssh_pageant_bin is not executable."
    fi
    unset wsl2_ssh_pageant_bin
  fi
fi
