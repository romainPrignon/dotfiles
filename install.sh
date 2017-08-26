#! /bin/sh

# le mettre dans un gist !

# pre-install
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# install: lib
apt update

apt install -y \
    build-essential \
    language-pack-en-base \
    software-properties-common

# install: app
add-apt-repository ppa:ultradvorka/ppa -y
apt update
apt install -y \
    curl \
    git \
    git-extras \
    hh \
    htop \
    shellcheck \
    sqlite3 \
    ssh \
    tree \
    vim \
    wget

# install: runtime

## node
curl -sSL http://git.io/n-install | bash
source ~/.bashrc
n latest
npm completion > npm
mv npm /etc/bash_completion.d/npm

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

## go
wget https://storage.googleapis.com/golang/go1.9.linux-amd64.tar.gz
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

npm install -g \
    babel-cli \
    http-server \
#    node-inspector \
    npm-check \
    nsp \
    pkgcount \
    ttystudio

# install: desktop

## FIXME: when gnome replace unity
# apt install -y \
#     lightdm \
#     gnome-core \
#     xfonts-base \
#     xserver-xorg

# apt install -y \
#     firefox \
#     ffmpeg
#     gnome-terminal \
#     gnome-tweak \
#     sublime-text \
#     ttf-dejavu

# post-install
# dpkg-reconfigure keyboard-configuration
