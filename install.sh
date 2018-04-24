#! /bin/sh

# pre-install
update-locale LANG=en_US.UTF-8

# install: lib
apt update

apt install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    dkms \
    gcc \
    language-pack-en-base \
    linux-headers-$(uname -r) \
    python3-software-properties \
    software-properties-common

# install: app
apt update
apt install -y \
    chrome-gnome-shell \
    curl \
    git \
    git-extras \
    gnome-shell-pomodoro \
    htop \
    python-pygments \
    shellcheck \
    sqlite3 \
    ssh \
    tree \
    vim \
    wget \
    wmctrl \
    xclip \
    zsh

snap install micro --classic

# qfc
git clone https://github.com/pindexis/qfc ~/.qfc

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

# install: zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/.zsh/zsh-git-prompt
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search

# install: bash
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# install: runtime

## node
curl -sSL https://git.io/n-install | bash

## php
add-apt-repository ppa:ondrej/php -y
apt update
apt install -y \
    php7.2-cli \
    php7.2-curl \
    php7.2-sqlite3 \
    php7.2-intl \
    php7.2-mysql \
    php7.2-zip \
    #php7.2-mcrypt \
    php7.2-mbstring \
    php7.2-json \
    php7.2-xml \
    php7.2-common \
    php7.2-opcache \
    php7.2-readline \
    php7.2-dev

curl -sSL https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

wget -c "https://xdebug.org/files/xdebug-2.5.5.tgz"
tar -xf xdebug-2.5.5.tgz
cd xdebug-2.5.5/
phpize
./configure
make && make install
echo 'zend_extension=xdebug.so' | tee --append /etc/php/7.2/mods-available/xdebug.ini
ln -sf /etc/php/7.1/mods-available/xdebug.ini /etc/php/7.2/cli/conf.d/20-xdebug.ini
echo '[XDebug]' | tee --append /etc/php/7.2/cli/php.ini
echo 'xdebug.remote_enable = 1' | tee --append /etc/php/7.2/cli/php.ini
echo 'xdebug.remote_autostart = 1' | tee --append /etc/php/7.2/cli/php.ini
rm -rf package.xml
rm -rf xdebug-2.5.5
rm -rf xdebug-2.5.5.tgz

## go
wget -q https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.10.1.linux-amd64.tar.gz

## python
apt install -y \
    python-pip

## java
apt install -y \
    openjdk-8-jdk

# docker
curl -sSL https://get.docker.com | bash
usermod -aG docker $(whoami)

# install: desktop

apt install -y \
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
    ffmpeg \
    gnome-calculator \
    gnome-paint \
    gnome-screenshot \
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

# post-install
apt autoremove --purge
apt clean
