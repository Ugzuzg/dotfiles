dotenv() {
  env $(grep -v '^#' $1 | xargs -d '\n') $@[2,-1]
}

alacritty-theme() {
  if [ ! -f ~/.config/alacritty/schemes.yml ]; then
    echo "file ~/.config/alacritty/schemes.yml doesn't exist"
    return
  fi

  sed -i -e "s#^colors: \*.*#colors: *$1#g" $(realpath ~/.config/alacritty/schemes.yml)

  echo "switched to $1."
}
