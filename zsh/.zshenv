export EDITOR=nvim
export BROWSER=firefox-nightly
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

dotenv() {
  env -S "`grep -v '^#' $1`" $@[2,-1]
}

alacritty-theme() {
  if [ ! -f ~/.config/alacritty/schemes.yml ]; then
    echo "file ~/.config/alacritty/schemes.yml doesn't exist"
    return
  fi

  sed -i -e "s#^colors: \*.*#colors: *$1#g" $(realpath ~/.config/alacritty/schemes.yml)

  echo "switched to $1."
}
