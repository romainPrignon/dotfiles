#! /bin/sh

set -x

## install: desktop
sudo apt install -y \
    chrome-gnome-shell \
    gdm3 \
    gnome-core \
    gnome-shell-extension-manager \
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
    gnome-tweaks \
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

# chrome
wget -q -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb
sudo apt -f -y install

# dbgate
wget -q -O /tmp/dbgate.deb https://github.com/dbgate/dbgate/releases/latest/download/dbgate-latest.deb
sudo dpkg -i /tmp/dbgate.deb
sudo apt -f -y install

# dbeaver
wget -q -O /tmp/dbeaver.deb https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i /tmp/dbeaver.deb
sudo apt -f -y install

# stacer
wget -q -O /tmp/stacer_1.1.0_amd64.deb https://github.com/oguzhaninan/Stacer/releases/download/v1.1.0/stacer_1.1.0_amd64.deb
sudo dpkg -i /tmp/stacer_1.1.0_amd64.deb
sudo apt -f -y install

# vscode
curl -sSL https://update.code.visualstudio.com/1.80.1/linux-deb-x64/stable --output /tmp/vscode.deb
sudo dpkg -i /tmp/vscode.deb
sudo apt -f -y install

# codeterm
curl -sSL "https://code.visualstudio.com/sha/download?build=insider&os=linux-deb-x64" --output /tmp/codeterm.deb
sudo dpkg -i /tmp/codeterm.deb
sudo apt -f -y install

# hyper
wget -q -O /tmp/hyper.deb https://github.com/vercel/hyper/releases/download/v3.4.1/hyper_3.4.1_amd64.deb
sudo dpkg -i /tmp/hyper.deb
sudo apt -f -y install

# micro
wget -q -O /tmp/micro.deb https://github.com/zyedidia/micro/releases/download/v2.0.11/micro-2.0.11-amd64.deb
sudo dpkg -i /tmp/micro.deb
sudo apt -f -y install

# rambox
curl -sSL "https://rambox.app/api/download?os=linux&package=deb" --output /tmp/rambox.deb
sudo dpkg -i /tmp/rambox.deb
sudo apt -f -y install

# subl
wget -q -O /tmp/sublime-text_build-4126_amd64.deb https://download.sublimetext.com/sublime-text_build-4126_amd64.deb
sudo dpkg -i /tmp/sublime-text_build-4126_amd64.deb
sudo apt -f -y install

# virtualbox
wget -q -O /tmp/virtualbox.deb https://download.virtualbox.org/virtualbox/7.0.8/virtualbox-7.0_7.0.8-156879~Ubuntu~jammy_amd64.deb
sudo dpkg -i /tmp/virtualbox.deb
sudo apt -f -y install

# vlc
sudo apt install vlc

# jetbrain toolbox
wget -q -O /tmp/jetbrains-toolbox.tar.gz https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.26.0.13072.tar.gz
tar -xf /tmp/jetbrains-toolbox.tar.gz -C /tmp
mv /tmp/jetbrains-toolbox-1.26.0.13072/jetbrains-toolbox $HOME/app/jetbrains-toolbox

# post-install
sudo apt autoremove --purge -y
sudo apt clean -y
