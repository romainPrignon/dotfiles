#! /bin/sh

# pre-install
export LANG=en_US.UTF-8

# install: lib
apt update

apt install -y \
    apt-transport-https \
    build-essential \
    language-pack-en-base \
    python-software-properties \
    software-properties-common

# install: app
add-apt-repository ppa:ultradvorka/ppa -y
apt update
apt install -y \
    chrome-gnome-shell \
    curl \
    git \
    git-extras \
    gnome-shell-pomodoro \
    hh \
    htop \
    python-pygments \
    shellcheck \
    sqlite3 \
    ssh \
    tree \
    vim \
    wget

# install: runtime

## node
curl -sSL http://git.io/n-install | bash

## php
add-apt-repository ppa:ondrej/php -y
apt update
apt install -y \
    php7.1-cli \
    php7.1-curl \
    php7.1-sqlite3 \
    php7.1-intl \
    php7.1-mysql \
    php7.1-zip \
    php7.1-mcrypt \
    php7.1-mbstring \
    php7.1-json \
    php7.1-xml \
    php7.1-common \
    php7.1-opcache \
    php7.1-readline \
    php7.1-dev

curl -sSL https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

wget -c "https://xdebug.org/files/xdebug-2.5.5.tgz"
tar -xf xdebug-2.5.5.tgz
cd xdebug-2.5.5/
phpize
./configure
make && make install
echo 'zend_extension=xdebug.so' | tee --append /etc/php/7.1/mods-available/xdebug.ini
ln -sf /etc/php/7.1/mods-available/xdebug.ini /etc/php/7.1/cli/conf.d/20-xdebug.ini

echo '[XDebug]' | tee --append /etc/php/7.1/cli/php.ini
echo 'xdebug.remote_enable = 1' | tee --append /etc/php/7.1/cli/php.ini
echo 'xdebug.remote_autostart = 1' | tee --append /etc/php/7.1/cli/php.ini

## go
wget -q https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.9.linux-amd64.tar.gz

## python
apt install -y \
    python-pip

## java
apt install -y \
    openjdk-8-jdk

git clone https://github.com/pindexis/qfc $HOME/.qfc
curl -sSL https://get.docker.com | bash
usermod -aG docker $(whoami)

# install: desktop

## FIXME: when gnome replace unity
apt install -y \
    gdm3 \
    gnome-core \
    xfonts-base \
    xserver-xorg

## install: desktop-app
add-apt-repository ppa:ravefinity-project/ppa
add-apt-repository ppa:alessandro-strada/ppa

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list

apt update

apt install -y \
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
    nautilus \
    sublime-text \
    synaptic \
    vibrancy-colors

## install: font
apt install -y \
    font-manager \
    fonts-inconsolata \
    fonts-droid-fallback \
    ttf-dejavu \
    ttf-ancient-fonts \
    ttf-ubuntu-font-family

wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
apt -f -y install

wget -qO atom.deb https://atom.io/download/deb
dpkg -i atom.deb
apt -f -y install

wget -qO vscode.deb https://go.microsoft.com/fwlink/?LinkID=760868
dpkg -i vscode.deb
apt -f -y install

wget -qO kraken.deb https://release.gitkraken.com/linux/gitkraken-amd64.deb
dpkg -i kraken.deb
apt -f -y install

# post-install
