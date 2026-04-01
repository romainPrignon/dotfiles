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

# mise (replaces asdf)
curl https://mise.run | sh
export PATH="$HOME/.local/bin:$PATH"
eval "$(mise activate bash)"

# docker
curl -sSL https://get.docker.com | bash
sudo usermod -aG docker $(whoami)

# docker-compose
wget -q -O $HOME/bin/docker-compose https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64
chmod u+x $HOME/bin/docker-compose

# docker compose
mkdir -p $HOME/.docker/cli-plugins/
wget -q -O $HOME/.docker/cli-plugins/docker-compose https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64
chmod u+x $HOME/.docker/cli-plugins/docker-compose

# post-install
sudo apt autoremove --purge -y
sudo apt clean -y
