#!/usr/bin/env zsh

env -S "`grep -v '^#' $1`" $@[2,-1]
