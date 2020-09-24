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
    python-pygments \
    python3-software-properties \
    software-properties-common \
    zlib1g-dev \
    libffi-dev \
    libbz2-dev \
    libreadline-dev \
    libssl-dev \
    libsqlite3-dev

# install: app
apt update
apt install -y \
    curl \
    ffmpeg \
    fzf \
    git \
    git-extras \
    htop \
    openssl \
    shellcheck \
    sqlite3 \
    ssh \
    tree \
    vim \
    wget \
    wmctrl \
    xclip \
    zsh

# micro
curl -sSL https://getmic.ro | bash

# n
wget -q -O $HOME/bin/n https://raw.githubusercontent.com/tj/n/master/bin/n
chmod u+x $HOME/bin/n

# install: zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/.zsh/zsh-git-prompt
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search

# install: bash
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# install: runtime

## node
$HOME/bin/n latest
$HOME/bin/n lts

## php
add-apt-repository ppa:ondrej/php -y
apt update
apt install -y \
    php7.4-apcu \
    php7.4-common \
    php7.4-cli \
    php7.4-curl \
    php7.4-dev \
    php7.4-intl \
    php7.4-json \
    php7.4-mbstring \
    php7.4-mysql \
    php7.4-opcache \
    php7.4-readline \
    php7.4-sqlite3 \
    php7.4-xml \
    php7.4-zip

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
wget -q https://dl.google.com/go/go1.15.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.15.2.linux-amd64.tar.gz

## python
curl https://pyenv.run | bash
apt install -y \
    python3-pip

## java
apt install -y \
    openjdk-11-jdk

# rust
rust_version="1.46.0"
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain $rust_version
source $HOME/.cargo/env
rustup default $rust_version

# docker
curl -sSL https://get.docker.com | bash
usermod -aG docker $(whoami)

# docker-compose
wget -q -O $HOME/bin/docker-compose https://github.com/docker/compose/releases/download/1.27.3/docker-compose-Linux-x86_64
chmod u+x $HOME/bin/docker-compose

# post-install
apt autoremove --purge -y
apt clean -y
