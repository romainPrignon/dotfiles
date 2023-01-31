#!/usr/bin/env bash

set -x

user="romainprignon"
dotfile_dir_absolute_path="/home/$user/workspace/romainprignon/dotfiles"
home_dir_absolute_path="/home/$user"

cd $home_dir_absolute_path

sudo mkdir -p /etc/resolvconf/resolv.conf.d

mkdir -p $home_dir_absolute_path/.rc/
mkdir -p $home_dir_absolute_path/.ssh/
mkdir -p $home_dir_absolute_path/.composer/
mkdir -p $home_dir_absolute_path/.config/Code/User/
mkdir -p $home_dir_absolute_path/.config/'Code - Insiders'/User/
mkdir -p $home_dir_absolute_path/.config/dconf/
mkdir -p $home_dir_absolute_path/.config/gtk-3.0/
mkdir -p $home_dir_absolute_path/.config/micro/
mkdir -p $home_dir_absolute_path/.config/sublime-text/Packages/User/
mkdir -p $home_dir_absolute_path/sandbox
mkdir -p $home_dir_absolute_path/workspace/partners
#mkdir -p $home_dir_absolute_path/workspace/go

# system
sudo ln -sf $dotfile_dir_absolute_path/etc/sysctl.conf /etc/sysctl.conf
sudo ln -sf $dotfile_dir_absolute_path/etc/resolvconf/head /etc/resolvconf/resolv.conf.d/head

ln -sf $dotfile_dir_absolute_path/.rc/common.rc $home_dir_absolute_path/.rc/common.rc
ln -sf $dotfile_dir_absolute_path/.composer/composer.json $home_dir_absolute_path/.composer/composer.json
ln -sf $dotfile_dir_absolute_path/.npmrc $home_dir_absolute_path/.npmrc
ln -sf $dotfile_dir_absolute_path/scripts $home_dir_absolute_path/scripts
ln -sf $dotfile_dir_absolute_path/.ssh/config $home_dir_absolute_path/.ssh/config
ln -sf $dotfile_dir_absolute_path/.vimrc $home_dir_absolute_path/.vimrc
ln -sf $dotfile_dir_absolute_path/micro/settings.json $home_dir_absolute_path/.config/micro/settings.json

# git
ln -sf $dotfile_dir_absolute_path/git/.gitconfig $home_dir_absolute_path/.gitconfig
ln -sf $dotfile_dir_absolute_path/git/.gitignore $home_dir_absolute_path/.gitignore

# prompt
ln -sf $dotfile_dir_absolute_path/.aliases $home_dir_absolute_path/.aliases
ln -sf $dotfile_dir_absolute_path/.exports $home_dir_absolute_path/.exports
ln -sf $dotfile_dir_absolute_path/.functions $home_dir_absolute_path/.functions

# bash
ln -sf $dotfile_dir_absolute_path/bash/.bashrc $home_dir_absolute_path/.bashrc
ln -sf $dotfile_dir_absolute_path/bash/Single_line_Ubuntu_Romain.bgptheme $home_dir_absolute_path/.bash-git-prompt/themes/Single_line_Ubuntu_Romain.bgptheme
ln -sf $dotfile_dir_absolute_path/bash/.inputrc $home_dir_absolute_path/.inputrc
ln -sf $dotfile_dir_absolute_path/bash/.profile $home_dir_absolute_path/.profile

# zsh
ln -sf $dotfile_dir_absolute_path/zsh/.zprofile $home_dir_absolute_path/.zprofile
ln -sf $dotfile_dir_absolute_path/zsh/.zshrc $home_dir_absolute_path/.zshrc
yes | cp -rf $dotfile_dir_absolute_path/zsh/zsh-git-prompt.sh $home_dir_absolute_path/.zsh/zsh-git-prompt/zshrc.sh
yes | cp -rf $dotfile_dir_absolute_path/zsh/gitstatus.py $home_dir_absolute_path/.zsh/zsh-git-prompt/gitstatus.py

# subl
ln -sf "$dotfile_dir_absolute_path/subl/Default (Linux).sublime-keymap" "$home_dir_absolute_path/.config/sublime-text/Packages/User/Default (Linux).sublime-keymap"
ln -sf "$dotfile_dir_absolute_path/subl/Preferences.sublime-settings" "$home_dir_absolute_path/.config/sublime-text/Packages/User/Preferences.sublime-settings"
ln -sf "$dotfile_dir_absolute_path/subl/Package Control.sublime-settings" "$home_dir_absolute_path/.config/sublime-text/Packages/User/Package Control.sublime-settings"

# gtk
ln -sf $dotfile_dir_absolute_path/gtk/gtk.css $home_dir_absolute_path/.config/gtk-3.0/gtk.css
ln -sf $dotfile_dir_absolute_path/gtk/bookmarks $home_dir_absolute_path/.config/gtk-3.0/bookmarks
ln -sf $dotfile_dir_absolute_path/gtk/settings.ini $home_dir_absolute_path/.config/gtk-3.0/settings.ini

# vscode
ln -sf $dotfile_dir_absolute_path/vscode/settings.json $home_dir_absolute_path/.config/Code/User/settings.json
ln -sf $dotfile_dir_absolute_path/vscode/keybindings.json $home_dir_absolute_path/.config/Code/User/keybindings.json

# codeterm
ln -sf $dotfile_dir_absolute_path/codeterm/settings.json $home_dir_absolute_path/.config/'Code - Insiders'/User/settings.json
ln -sf $dotfile_dir_absolute_path/codeterm/keybindings.json $home_dir_absolute_path/.config/'Code - Insiders'/User/keybindings.json

# hyper
ln -sf $dotfile_dir_absolute_path/.hyper.js $home_dir_absolute_path/.hyper.js

# completions
ln -sf $dotfile_dir_absolute_path/.completions $home_dir_absolute_path/.completions
ln -sf $dotfile_dir_absolute_path/.zcompletions $home_dir_absolute_path/.zcompletions

# fzf
bash $HOME/.fzf/install --key-bindings --completion --no-update-rc

# python
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 2

# pip
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# dns
sudo service resolvconf restart

# tlp
sudo systemctl enable tlp

# system
sudo sysctl --system

source "$HOME/.profile"

