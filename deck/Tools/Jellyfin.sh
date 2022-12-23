#!/usr/bin/bash

#weston
#export XDG_SESSTION_TYPE=wayland
#waydroid show-full-ui
#
#WAYLAND_DISPLAY=gamescope-0 waydroid show-full-ui > /home/deck/waydroid-ui
#
flatpak run --branch=stable --arch=x86_64 com.github.iwalton3.jellyfin-media-player --tv --fullscreen "$@"
