#!/usr/bin/env bash

# pre-install
dpkg-reconfigure keyboard-configuration
add-apt-repository ppa:ondrej/php

apt-get update

# install: lib
apt install -y \
    software-properties-common \
    build-essential \

# install: runtime

## node
wget http://git.io/n-install | bash
n use latest

## php
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

wget https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

## go

## python
apt install -y \
    python-pip

## java
apt install -y \
    openjdk-8-jdk

# install: app
apt install -y \
    curl

# install: desktop

## FIXME: when gnome replace unity
apt install -y \
    lightdm \
    gnome-core \
    xfonts-base \
    xserver-xorg

#



#sublime-text
#gnome-tweak
#ttf-dejavu
#ffmpeg (webmtogif)
