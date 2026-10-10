ZDOTDIR="$HOME/.config/zsh"

export EDITOR=nvim
export BROWSER=firefox-nightly
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export PI_CODING_AGENT_DIR="$HOME/.config/pi"

#alacritty-theme() {
#  if [ ! -f ~/.config/alacritty/schemes.yml ]; then
#    echo "file ~/.config/alacritty/schemes.yml doesn't exist"
#    return
#  fi
#
#  sed -i -e "s#^colors: \*.*#colors: *$1#g" $(realpath ~/.config/alacritty/schemes.yml)
#
#  echo "switched to $1."
#}
