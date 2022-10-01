#! /bin/sh

set -x

# pre-install
mkdir ~/app
mkdir ~/bin

# install: lib
sudo apt update

sudo apt install -y \
    apt-transport-https \
    apt-utils \
    build-essential \
    ca-certificates \
    dkms \
    gcc \
    language-pack-en-base \
    linux-headers-generic \
    locales \
    python3-pygments \
    python3-software-properties \
    software-properties-common \
    smartmontools \
    zlib1g-dev \
    libffi-dev \
    libbz2-dev \
    libreadline-dev \
    libssl-dev \
    libsqlite3-dev \
    libglib2.0-dev-bin

sudo locale-gen fr_FR fr_FR.UTF-8
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8

# install: app
sudo apt update
sudo apt install -y \
    curl \
    ffmpeg \
    git \
    git-extras \
    htop \
    jq \
    net-tools \
    openssl \
    resolvconf \
    shellcheck \
    snapd \
    sqlite3 \
    ssh \
    tar \
    tree \
    unzip \
    vim \
    wget \
    wmctrl \
    xclip \
    zsh

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

# micro
cd $HOME/bin
curl -sSL https://getmic.ro | bash
cd -

# install: zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/.zsh/zsh-git-prompt
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search

# bash
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# runtime

# n
curl -sSL https://git.io/n-install | bash -s -- -y -n latest lts

# deno
curl -sSL https://deno.land/x/install/install.sh | bash

## deno: config
$HOME/.deno/bin/deno completions bash > deno
sudo mv deno /etc/bash_completion.d/deno

## php
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install -y \
    php8.1-apcu \
    php8.1-common \
    php8.1-cli \
    php8.1-curl \
    php8.1-dev \
    php8.1-intl \
    php8.1-mbstring \
    php8.1-mysql \
    php8.1-opcache \
    php8.1-readline \
    php8.1-sqlite3 \
    php8.1-xdebug \
    php8.1-xml \
    php8.1-zip

curl -sSL https://getcomposer.org/installer | php -- --install-dir=/$HOME/bin --filename=composer

## go
#wget -q -O /tmp/go1.15.2.linux-amd64.tar.gz https://dl.google.com/go/go1.15.2.linux-amd64.tar.gz
#sudo tar -C /usr/local -xzf /tmp/go1.15.2.linux-amd64.tar.gz

## python
curl https://pyenv.run | bash
sudo apt install -y \
    python3-pip \
    python3-venv

## poetry
poetry_path=$HOME/.poetry
python3 -m venv $poetry_path
$poetry_path/bin/pip install -U pip setuptools
$poetry_path/bin/pip install poetry
$poetry_path/bin/poetry config virtualenvs.in-project true

## java
sudo apt install -y \
    openjdk-17-jdk

# rust
rust_version="1.64.0"
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain $rust_version
source $HOME/.cargo/env
rustup default $rust_version

# docker
curl -sSL https://get.docker.com | bash
sudo usermod -aG docker $(whoami)

# docker-compose
wget -q -O $HOME/bin/docker-compose https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64
chmod u+x $HOME/bin/docker-compose

# docker compose
mkdir -p $HOME/.docker/cli-plugins/
wget -q -O $HOME/.docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.11.1/docker-compose-linux-x86_64
chmod u+x $HOME/.docker/cli-plugins/docker-compose

# ansible
sudo apt install -y ansible

# packer
wget -q -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.8.3/packer_1.8.3_linux_amd64.zip
unzip /tmp/packer.zip
mv packer $HOME/bin/packer
chmod u+x $HOME/bin/packer

# multipass
sudo snap install multipass

# terraform
wget -q -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/1.3.0/terraform_1.3.0_linux_amd64.zip
unzip /tmp/terraform.zip
mv terraform $HOME/bin/terraform
chmod u+x $HOME/bin/terraform

# gh
wget -q -O /tmp/gh.tar.gz https://github.com/cli/cli/releases/download/v2.16.0/gh_2.16.0_linux_amd64.tar.gz
tar -C /tmp -xzf /tmp/gh.tar.gz
mv gh_2.16.0_linux_amd64/bin/gh $HOME/bin/gh
chmod u+x $HOME/bin/gh

# post-install
sudo apt autoremove --purge -y
sudo apt clean -y
