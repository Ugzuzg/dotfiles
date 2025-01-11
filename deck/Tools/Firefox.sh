#!/usr/bin/bash

MOZ_ENABLE_WAYLAND=1 gamescope --expose-wayland -f -e -- env WAYLAND_DISPLAY='any' firefox-nightly --window-size 1280,800 "$@"
