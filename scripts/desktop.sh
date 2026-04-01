#! /bin/sh

set -x

dotfile_dir_absolute_path="/home/romainprignon/workspace/romainprignon/dotfiles"

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

# ghostty terminal
wget -q -O /tmp/ghostty.deb https://github.com/ghostty-org/ghostty/releases/latest/download/ghostty_linux_x86_64.deb
sudo dpkg -i /tmp/ghostty.deb
sudo apt -f -y install

## install: font
# Install fonts from git repository
sudo mkdir -p /usr/local/share/fonts/truetype/jetbrains-mono
sudo mkdir -p /usr/local/share/fonts/truetype/dejavu
sudo mkdir -p /usr/local/share/fonts/truetype/ubuntu

# Copy fonts to system
sudo cp -r $dotfile_dir_absolute_path/fonts/jetbrains-mono/*.ttf /usr/local/share/fonts/truetype/jetbrains-mono/ 2>/dev/null || true
sudo cp -r $dotfile_dir_absolute_path/fonts/dejavu/*.ttf /usr/local/share/fonts/truetype/dejavu/ 2>/dev/null || true
sudo cp -r $dotfile_dir_absolute_path/fonts/ubuntu/*.ttf /usr/local/share/fonts/truetype/ubuntu/ 2>/dev/null || true

# Refresh font cache
sudo fc-cache -f -v

sudo apt install -y \
    font-manager \
    fonts-droid-fallback \
    fonts-inconsolata \
    fonts-liberation \
    ttf-ancient-fonts

# brave browser
wget -q -O /tmp/brave-browser_current_amd64.deb https://github.com/brave/brave-browser/releases/latest/download/brave-browser_current_amd64.deb || \
    curl -fsSL https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/brave-browser-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list && \
    sudo apt update && sudo apt install -y brave-browser

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
