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
    python-pygments \
    python3-software-properties \
    resolvconf \
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
    net-tools \
    openssl \
    shellcheck \
    sqlite3 \
    ssh \
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

# n
curl -sSL https://git.io/n-install | bash -s -- -y -n latest lts


# install: zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/olivierverdier/zsh-git-prompt.git ~/.zsh/zsh-git-prompt
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search

# bash
git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

# runtime

## node: config
npm completion > npm
sudo mv npm /etc/bash_completion.d/npm

# deno
curl -sSL https://deno.land/x/install/install.sh | bash

## deno: config
$HOME/.deno/bin/deno completions bash > deno
sudo mv deno /etc/bash_completion.d/deno

## php
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update
sudo apt install -y \
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

curl -sSL https://getcomposer.org/installer | php -- --install-dir=/$HOME/bin --filename=composer

wget -c "https://xdebug.org/files/xdebug-2.9.8.tgz"
tar -xf xdebug-2.9.8.tgz
cd xdebug-2.9.8/
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
rm -rf xdebug-2.9.8
rm -rf xdebug-2.9.8.tgz

## go
#wget -q -O /tmp/go1.15.2.linux-amd64.tar.gz https://dl.google.com/go/go1.15.2.linux-amd64.tar.gz
#sudo tar -C /usr/local -xzf /tmp/go1.15.2.linux-amd64.tar.gz

## python
curl https://pyenv.run | bash
sudo apt install -y \
    python3-pip

## java
sudo apt install -y \
    openjdk-11-jdk

# rust
rust_version="1.46.0"
curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain $rust_version
source $HOME/.cargo/env
rustup default $rust_version

# docker
curl -sSL https://get.docker.com | bash
sudo usermod -aG docker $(whoami)

# docker-compose
wget -q -O $HOME/bin/docker-compose https://github.com/docker/compose/releases/download/1.27.3/docker-compose-Linux-x86_64
chmod u+x $HOME/bin/docker-compose

# ansible
sudo apt install -y ansible

# packer
wget -q -O /tmp/packer.zip https://releases.hashicorp.com/packer/1.6.4/packer_1.6.4_linux_amd64.zip
unzip /tmp/packer.zip
mv packer $HOME/bin/packer
chmod u+x $HOME/bin/packer

# multipass
sudo snap install multipass

# terraform
wget -q -O /tmp/terraform.zip https://releases.hashicorp.com/terraform/1.0.5/terraform_1.0.5_linux_amd64.zip
unzip /tmp/terraform.zip
mv terraform $HOME/bin/terraform
chmod u+x $HOME/bin/terraform

# gh
wget -q -O /tmp/gh.tar.gz https://github.com/cli/cli/releases/download/v1.14.0/gh_1.14.0_linux_amd64.tar.gz
tar -xzf /tmp/gh.tar.gz
mv gh_1.14.0_linux_amd64/bin/gh $HOME/bin/gh
chmod u+x $HOME/bin/gh

# lazydocker
wget -q -O /tmp/lazydocker.tar.gz https://github.com/jesseduffield/lazydocker/releases/download/v0.12/lazydocker_0.12_Linux_x86_64.tar.gz
tar -xzf /tmp/lazydocker.tar.gz
mv lazydocker $HOME/bin/lazydocker
chmod u+x $HOME/bin/lazydocker

# lazygit
wget -q -O /tmp/lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/download/v0.29/lazygit_0.29_Linux_x86_64.tar.gz
tar -xzf /tmp/lazygit.tar.gz
mv lazygit $HOME/bin/lazygit
chmod u+x $HOME/bin/lazygit

# post-install
sudo apt autoremove --purge -y
sudo apt clean -y
