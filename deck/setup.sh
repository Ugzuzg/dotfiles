#!/usr/bin/bash -xe

# Install flatpaks
flatpak install --noninteractive --or-update flathub \
    `# Apps` \
    com.bitwarden.desktop \
    com.discordapp.Discord \
    com.github.iwalton3.jellyfin-media-player \
    com.github.tchx84.Flatseal \
    net.davidotek.pupgui2 \
    org.gnome.Platform.Compat.i386//43
flatpak install --noninteractive --or-update flathub-beta \
    net.lutris.Lutris

# Install system packages
sudo steamos-readonly disable
sudo pacman-key --init
sudo pacman-key --populate archlinux

if ! grep -qe "heftig" /etc/pacman.conf; then
  cat <<EOF | sudo tee -a /etc/pacman.conf

[heftig]
SigLevel = Optional
Server = https://pkgbuild.com/~heftig/repo/\$arch
EOF
fi

# reinstall openssl
# rust fails to build things otherwise
yay -Sy --noconfirm --overwrite '*' openssl
yay -Sy --noconfirm --needed --overwrite '*' \
    zsh zoxide bat tmux base-devel exa \
    rustup \
    lib32-freetype2 \
    fakeroot p7zip unrar \
    steam-boilr-gui itch-bin antigen \
    neovim dotter-rs-bin \
    firefox-nightly

sudo usermod -s /bin/zsh deck

# sudo steamos-readonly enable
