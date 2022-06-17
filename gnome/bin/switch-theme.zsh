#!/bin/zsh

case $1 in
  dark)
    echo "dark"
    alacritty-theme zenburn
    ;;
  light)
    echo "light"
    alacritty-theme one
    ;;
esac

/usr/bin/killall -USR1 nvim
