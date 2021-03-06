#! /bin/sh

set -x

## install: desktop
sudo apt install -y \
    chrome-gnome-shell \
    gdm3 \
    gnome-core \
    xfonts-base \
    xserver-xorg

## install: desktop-app

sudo apt update

sudo apt install -y \
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
    synaptic \
    tlp

## install: font
sudo apt install -y \
    font-manager \
    fonts-droid-fallback \
    fonts-inconsolata \
    fonts-liberation \
    ttf-dejavu \
    ttf-ancient-fonts \
    ttf-ubuntu-font-family

# chrome
wget -q -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
sudo apt -f -y install

# stacer
wget -q -O /tmp/stacer_1.1.0_amd64.deb https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb
sudo dpkg -i /tmp/stacer_1.1.0_amd64.deb
sudo apt -f -y install

# hyper
wget -q -O $HOME/app/hyper.AppImage https://releases.hyper.is/download/AppImage
chmod a+x $HOME/app/hyper.AppImage

# vscode
wget -q -O /tmp/vscode.deb https://update.code.visualstudio.com/1.49.1/linux-deb-x64/stable
sudo dpkg -i /tmp/vscode.deb
sudo apt -f -y install

# subl
wget -q -O /tmp/sublime-text_build-3211_amd64.deb https://download.sublimetext.com/sublime-text_build-3211_amd64.deb
sudo dpkg -i /tmp/sublime-text_build-3211_amd64.deb
sudo apt -f -y install

# jetbrain toolbox
wget -q -O /tmp/jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.18.7455.tar.gz
tar -xf /tmp/jetbrains-toolbox.tar.gz -C /tmp
mv /tmp/jetbrains-toolbox-1.18.7455/jetbrains-toolbox $HOME/app/jetbrains-toolbox

# post-install
sudo apt autoremove --purge -y
sudo apt clean -y
