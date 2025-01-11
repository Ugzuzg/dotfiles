#!/usr/bin/bash -xe

# Install system packages
sudo steamos-readonly disable
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman-key --populate holo

#sudo sed -i -E 's/\[(jupiter|holo|core|extra|community|multilib)-rel\]/[\1-main]/g' /etc/pacman.conf

paru -Sy --noconfirm archlinux-keyring
# paru -S --noconfirm openssl openssl-1.1 --overwrite '*'

paru -S --noconfirm --needed --overwrite '*' \
  zsh zoxide bat zellij base-devel glibc linux-api-headers \
  lib32-freetype2 \
  fakeroot unrar \
  antigen eza vifm \
  neovim \
  dotter-rs-bin

sudo usermod -s /bin/zsh deck

#sudo steamos-readonly enable

# Install flatpaks
flatpak install --system --noninteractive --or-update flathub \
  `# Apps` \
  net.lutris.Lutris \
  io.itch.itch \
  com.bitwarden.desktop \
  com.discordapp.Discord \
  com.github.iwalton3.jellyfin-media-player \
  com.steamgriddb.steam-rom-manager \
  com.github.tchx84.Flatseal \
  net.davidotek.pupgui2
