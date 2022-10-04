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
    gnome-calculator \
    gnome-paint \
    gnome-screenshot \
    gnome-system-log \
    gnome-terminal \
    gnome-tweak-tool \
    nautilus \
    simplescreenrecorder \
    synaptic \
    tlp

## install: font
sudo apt install -y \
    font-manager \
    fonts-droid-fallback \
    fonts-inconsolata \
    fonts-liberation \
    ttf-ancient-fonts

## install focal fonts
sudo apt install -y \
    ttf-dejavu \
    ttf-ubuntu-font-family

## install jammy fonts
sudo apt install -y \
    fonts-dejavu \
    fonts-ubuntu \
    fonts-ubuntu-console

# zap
curl https://raw.githubusercontent.com/srevinsaju/zap/main/install.sh | sudo bash -s

# chrome
wget -q -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
sudo apt -f -y install

# stacer
zap install --github --from oguzhaninan/Stacer

# hyper
zap install --github --from vercel/hyper

# subl
wget -q -O /tmp/sublime-text_build-4126_amd64.deb https://download.sublimetext.com/sublime-text_build-4126_amd64.deb
sudo dpkg -i /tmp/sublime-text_build-4126_amd64.deb
sudo apt -f -y install

# jetbrain toolbox
wget -q -O /tmp/jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.26.0.13072.tar.gz
tar -xf /tmp/jetbrains-toolbox.tar.gz -C /tmp
mv /tmp/jetbrains-toolbox-1.26.0.13072/jetbrains-toolbox $HOME/app/jetbrains-toolbox

# post-install
sudo apt autoremove --purge -y
sudo apt clean -y
