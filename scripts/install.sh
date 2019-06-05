#! /bin/sh

set -x

# pre-install
locale-gen en_US en_US.UTF-8
update-locale LANG=en_US.UTF-8

mkdir ~/app

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
    curl \
    ffmpeg \
    git \
    git-extras \
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
    php-pear \
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
cd ..
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

# rust
rust_version="1.34.1"
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain $rust_version
source $HOME/.cargo/env
rustup default $rust_version

# docker
curl -sSL https://get.docker.com | bash
usermod -aG docker $(whoami)

# post-install
apt autoremove --purge -y
apt clean -y
