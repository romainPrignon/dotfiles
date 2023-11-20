#! /bin/sh

set -x

# pre-install
mkdir ~/app
mkdir ~/bin

# lib
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

# app
sudo apt update
sudo apt install -y \
    curl \
    ffmpeg \
    git \
    git-extras \
    grep \
    htop \
    jq \
    make \
    mmv \
    net-tools \
    openssl \
    pv \
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

# zsh
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone --depth=1 https://github.com/olivierverdier/zsh-git-prompt.git ~/.zsh/zsh-git-prompt
git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
git clone --depth=1 https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab

# bash
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

# asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
source $HOME/.asdf/asdf.sh

# runtime

# n
sudo apt install -y dirmngr gpg curl gawk
asdf plugin add node https://github.com/asdf-vm/asdf-nodejs.git
asdf install node latest
asdf install node lts
asdf global node lts

# deno
sudo apt install -y curl git unzip
asdf plugin-add deno https://github.com/asdf-community/asdf-deno.git
asdf install deno 1.35.1
asdf global deno 1.35.1

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
sudo apt install -y curl coreutils
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install golang 1.20.6
asdf global golang 1.20.6

## python
sudo apt install -y \
    build-essential curl llvm make wget \
    zlib1g-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev liblzma-dev libffi-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev
asdf plugin add python https://github.com/asdf-community/asdf-python.git
asdf install python 3.8.2
asdf install python 2.7.18
asdf global python 3.8.2 2.7.18

## poetry
asdf plugin-add poetry https://github.com/asdf-community/asdf-poetry.git
asdf install poetry 1.5.1
asdf global poetry 1.5.1
poetry config virtualenvs.in-project true

## java
sudo apt install -y \
    openjdk-17-jdk

# rust
asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
asdf install rust 1.70.0
asdf global rust 1.70.0

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

# packer
asdf plugin-add packer https://github.com/asdf-community/asdf-hashicorp.git
asdf install packer 1.8.3
asdf global packer 1.8.3

# terraform
asdf plugin-add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf install terraform 1.3.1
asdf global terraform 1.3.1

# gh
asdf plugin-add github-cli https://github.com/bartlomiejdanek/asdf-github-cli.git
asdf install github-cli 2.16.1
asdf global github-cli 2.16.1

# kubectl
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf install kubectl 1.25.2
asdf global kubectl 1.25.2

# krew
bash ./scripts/krew.sh

# broot
asdf plugin-add broot https://github.com/cmur2/asdf-broot.git
asdf install broot 1.21.1
asdf global broot 1.21.1

# post-install
sudo apt autoremove --purge -y
sudo apt clean -y
