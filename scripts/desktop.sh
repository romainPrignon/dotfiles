#! /bin/sh

set -x

## install: desktop
apt install -y \
    chrome-gnome-shell \
    gdm3 \
    gnome-core \
    xfonts-base \
    xserver-xorg

## install: desktop-app
add-apt-repository ppa:alessandro-strada/ppa -y

apt update

apt install -y \
    arc-theme \
    eog \
    evince \
    firefox \
    gnome-calculator \
    gnome-paint \
    gnome-screenshot \
    gnome-shell-pomodoro \
    gnome-system-log \
    gnome-terminal \
    gnome-tweak-tool \
    google-drive-ocamlfuse \
    nautilus \
    nautilus-dropbox \
    synaptic

## install: font
apt install -y \
    font-manager \
    fonts-droid-fallback \
    fonts-inconsolata \
    fonts-liberation \
    ttf-dejavu \
    ttf-ancient-fonts \
    ttf-ubuntu-font-family

wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
apt -f -y install

snap install gitkraken --classic
snap install sublime-text --classic
snap install vscode --classic

wget -q https://sourceforge.net/projects/stacer/files/v1.0.9/Stacer-x64.AppImage/download -O ~/app/stacer.AppImage
chmod a+x ~/app/stacer.AppImage

# post-install
apt autoremove --purge -y
apt clean -y
