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

# google-drive-ocamlfuse \
apt install -y \
    arc-theme \
    eog \
    evince \
    firefox \
    gnome-calculator \
    gnome-paint \
    gnome-screenshot \
    gnome-system-log \
    gnome-terminal \
    gnome-tweak-tool \
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

# chrome
wget -q -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i /tmp/google-chrome-stable_current_amd64.deb
apt -f -y install

# stacer
wget -q -O /tmp/stacer_1.1.0_amd64.deb https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb
dpkg -i /tmp/stacer_1.1.0_amd64.deb
apt -f -y install

# vscode
wget -q -O /tmp/vscode.deb https://update.code.visualstudio.com/1.49.1/linux-deb-x64/stable
dpkg -i /tmp/vscode.deb
apt -f -y install

# subl
wget -q -O /tmp/sublime-text_build-3211_amd64.deb https://download.sublimetext.com/sublime-text_build-3211_amd64.deb
dpkg -i /tmp/sublime-text_build-3211_amd64.deb
apt -f -y install

# post-install
apt autoremove --purge -y
apt clean -y
