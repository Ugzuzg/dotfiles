ZFUNCDIR=${ZDOTDIR:-$HOME}/functions
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(D@:t)

if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/zsh_plugins.txt

# setopt extended_glob

compdef _pacman paru=pacman

# auto rehash on completion
zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' gain-privileges 1

if (( $+commands[fnm] )); then
  eval "`fnm env --use-on-cd`"
fi

if (( $+commands[jj] )); then
  source <(COMPLETE=zsh jj)
fi


if [ "$TERM_PROGRAM" != "vscode" ]; then
  eval "$(zellij setup --generate-auto-start zsh)"
fi

for _rc in ${ZDOTDIR:-$HOME}/zshrc.d/*.zsh; do
  # Ignore tilde files.
  if [[ $_rc:t != '~'* ]]; then
    source "$_rc"
  fi
done
unset _rc

# pnpm
export PNPM_HOME='/home/ugzuzg/.local/share/pnpm'
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end


typeset -g _wezm_jj_display=""
typeset -g _wezm_jj_workspace=""

# https://andre.arko.net/2025/06/20/a-jj-prompt-for-powerlevel10k/
_wezm_jj_async() {
  local ws=$1 revision bookmark distance file_status display
  revision=$(jj log --repository "$ws" --ignore-working-copy --no-graph --limit 1 \
    --color always -r @ -T 'prompt' 2>/dev/null)
  bookmark=$(jj log --repository "$ws" --ignore-working-copy --no-graph --limit 1 \
    -r 'closest_bookmark(@)' -T 'bookmarks.map(|b| b.name()).join(" ")' 2>/dev/null)
  bookmark=${bookmark%% *}
  distance=$(jj log --repository "$ws" --ignore-working-copy --no-graph --color never \
    -r 'closest_bookmark(@)..@ & (~empty() | merges())' -T '"n"' 2>/dev/null | wc -c | tr -d ' ')
  local ahead=0 behind=0 color=green counts
  if [[ -n $bookmark ]]; then
    counts=($(jj bookmark list --repository "$ws" --ignore-working-copy "exact:$bookmark" \
      -T 'if(remote && remote != "git", separate(" ", tracking_ahead_count.lower(), tracking_behind_count.lower()) ++ "\n")' \
      2>/dev/null | head -1))
    ahead=${counts[1]:-0} behind=${counts[2]:-0}
    (( ahead )) && color=cyan
    (( behind )) && color=magenta
    (( ahead && behind )) && color=red
  fi
  file_status=$(jj log --repository "$ws" --ignore-working-copy --no-graph --color never \
    -r @ -T 'self.diff().files().map(|f| f.status()).join("\n")' 2>/dev/null |
    sort | uniq -c | awk '
      /modified/ { p[++i] = "%F{cyan}±" $1 "%f" }
      /added/    { p[++i] = "%F{green}+" $1 "%f" }
      /removed/  { p[++i] = "%F{red}-" $1 "%f" }
      /copied/   { p[++i] = "%F{yellow}⧉" $1 "%f" }
      /renamed/  { p[++i] = "%F{magenta}↻" $1 "%f" }
      END { for (j=1; j<=i; j++) printf "%s%s", p[j], (j<i ? " " : "") }')
  display=$revision
  if [[ -n $bookmark ]]; then
    display+=" %F{$color}${bookmark}"
    (( distance > 0 )) && display+="›${distance}"
    (( behind )) && display+=" ⇣${behind}"
    (( ahead )) && display+="$( (( behind )) || print -n ' ' )⇡${ahead}"
    display+="%f"
  fi
  [[ -n $file_status ]] && display+=" $file_status"
  print -r -- "$display" | sed 's/\x1b\[[0-9;]*m/%{&%}/g'
}

_wezm_jj_callback() {
  local exit_code=$2 output=$3 stderr=$5
  if [[ $exit_code == 0 ]]; then
    _wezm_jj_display=$output
  else
    _wezm_jj_display="$output %F{red}$stderr%f"
  fi
  zle && zle reset-prompt
}

async_init
async_stop_worker _wezm_jj_worker 2>/dev/null
async_start_worker _wezm_jj_worker
async_unregister_callback _wezm_jj_worker 2>/dev/null
async_register_callback _wezm_jj_worker _wezm_jj_callback

_wezm_jj_precmd() {
  local ws
  if ws=$(jj workspace root 2>/dev/null); then
    if [[ $_wezm_jj_workspace != "$ws" ]]; then
      _wezm_jj_display=""
      _wezm_jj_workspace=$ws
    fi
    async_job _wezm_jj_worker _wezm_jj_async "$ws"
  else
    _wezm_jj_workspace=""
    _wezm_jj_display=""
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _wezm_jj_precmd

_wezm_vcs_prompt_info() {
  if [[ -n $_wezm_jj_workspace ]]; then
    [[ -n $_wezm_jj_display ]] && echo "${_wezm_jj_display} "
  else
    git_prompt_info
  fi
}

PROMPT='%{${fg_bold[yellow]}%}%n%{$reset_color%}%{${fg[yellow]}%}@%m%{$reset_color%} $(_wezm_vcs_prompt_info)%(?,,%{${fg_bold[white]}%}[%?]%{$reset_color%} )%{$fg[yellow]%}%#%{$reset_color%} '
RPROMPT='%{$fg[green]%}%~%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
