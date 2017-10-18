#!/usr/bin/env bash

user="romainprignon"
dotfile_dir_absolute_path="/home/$user/workspace/romainprignon/dotfiles"
home_dir_absolute_path="/home/$user"

cd $home_dir_absolute_path

mkdir app
mkdir .atom
mkdir -p $home_dir_absolute_path/.config/dconf
mkdir -p $home_dir_absolute_path/.config/micro
mkdir -p $home_dir_absolute_path/.config/sublime-text-3/Packages/User
mkdir -p $home_dir_absolute_path/.config/Code/User
mkdir drive-pro
mkdir drive-peaks
mkdir -p $home_dir_absolute_path/.gdfuse/pro
mkdir -p $home_dir_absolute_path/.gdfuse/peaks
mkdir .ssh

sudo chown -R $user:$user $home_dir_absolute_path/.composer
sudo chown -R $user:$user $home_dir_absolute_path/n
sudo chown -R $user:$user $home_dir_absolute_path/.qfc
sudo chown -R $user:$user $home_dir_absolute_path/.fzf
sudo chown -R $user:$user $home_dir_absolute_path/.enhancd
sudo chown -R $user:$user $home_dir_absolute_path/.zsh
sudo chown -R $user:$user $home_dir_absolute_path/.bash-git-prompt

wget -qO ~/app/hyper.AppImage https://releases.hyper.is/download/AppImage

ln -sf $dotfile_dir_absolute_path/.atom/config.cson $home_dir_absolute_path/.atom/config.cson
ln -sf $dotfile_dir_absolute_path/.atom/keymap.cson $home_dir_absolute_path/.atom/keymap.cson
ln -sf $dotfile_dir_absolute_path/.atom/snippets.cson $home_dir_absolute_path/.atom/snippets.cson
ln -sf $dotfile_dir_absolute_path/.atom/styles.less $home_dir_absolute_path/.atom/styles.less
ln -sf $dotfile_dir_absolute_path/.composer/composer.json $home_dir_absolute_path/.composer/composer.json
#ln -sf $dotfile_dir_absolute_path/scripts $home_dir_absolute_path/scripts @FIXME
ln -sf $dotfile_dir_absolute_path/.gitattributes $home_dir_absolute_path/.gitattributes
ln -sf $dotfile_dir_absolute_path/.gitconfig $home_dir_absolute_path/.gitconfig
ln -sf $dotfile_dir_absolute_path/.gitignore $home_dir_absolute_path/.gitignore
ln -sf $dotfile_dir_absolute_path/.vimrc $home_dir_absolute_path/.vimrc
ln -sf $dotfile_dir_absolute_path/.aliases $home_dir_absolute_path/.aliases
ln -sf $dotfile_dir_absolute_path/.bashrc $home_dir_absolute_path/.bashrc
ln -sf $dotfile_dir_absolute_path/.exports $home_dir_absolute_path/.exports
ln -sf $dotfile_dir_absolute_path/.exports_linux $home_dir_absolute_path/.exports_linux
ln -sf $dotfile_dir_absolute_path/.functions $home_dir_absolute_path/.functions
ln -sf $dotfile_dir_absolute_path/Single_line_Ubuntu_Romain.bgptheme $home_dir_absolute_path/.bash-git-prompt/themes/Single_line_Ubuntu_Romain.bgptheme
ln -sf $dotfile_dir_absolute_path/.inputrc $home_dir_absolute_path/.inputrc
ln -sf $dotfile_dir_absolute_path/.profile $home_dir_absolute_path/.profile
ln -sf $dotfile_dir_absolute_path/.ssh/config $home_dir_absolute_path/.ssh/config
ln -sf $dotfile_dir_absolute_path/.npmrc $home_dir_absolute_path/.npmrc
ln -sf $dotfile_dir_absolute_path/.hyper.js $home_dir_absolute_path/.hyper.js
ln -sf "$dotfile_dir_absolute_path/subl/Default (Linux).sublime-keymap" "$home_dir_absolute_path/.config/sublime-text-3/Packages/User/Default (Linux).sublime-keymap"
ln -sf "$dotfile_dir_absolute_path/subl/Preferences.sublime-settings" "$home_dir_absolute_path/.config/sublime-text-3/Packages/User/Preferences.sublime-settings"
ln -sf "$dotfile_dir_absolute_path/subl/Package Control.sublime-settings" "$home_dir_absolute_path/.config/sublime-text-3/Packages/User/Package Control.sublime-settings"
ln -sf $dotfile_dir_absolute_path/.gdfuse/pro/config $home_dir_absolute_path/.gdfuse/pro/config
ln -sf $dotfile_dir_absolute_path/.gdfuse/peaks/config $home_dir_absolute_path/.gdfuse/peaks/config
ln -sf $dotfile_dir_absolute_path/vscode/settings.json $home_dir_absolute_path/.config/Code/User/settings.json
ln -sf $dotfile_dir_absolute_path/vscode/keybindings.json $home_dir_absolute_path/.config/Code/User/keybindings.json
ln -sf $dotfile_dir_absolute_path/micro/settings.json $home_dir_absolute_path/.config/micro/settings.json
ln -sf $dotfile_dir_absolute_path/.zprofile $home_dir_absolute_path/.zprofile
ln -sf $dotfile_dir_absolute_path/.zshrc $home_dir_absolute_path/.zshrc
yes | cp -rf $dotfile_dir_absolute_path/zsh-git-prompt.sh $home_dir_absolute_path/.zsh/zsh-git-prompt/zshrc.sh
yes | cp -rf $dotfile_dir_absolute_path/gitstatus.py $home_dir_absolute_path/.zsh/zsh-git-prompt/gitstatus.py

# ln -sf $dotfile_dir_absolute_path/preferences /etc/apt/preferences

dconf load /org/gnome/nautilus/ < $dotfile_dir_absolute_path/dconf/nautilus.dconf
dconf load /org/gnome/power-manager/ < $dotfile_dir_absolute_path/dconf/power-manager.dconf
dconf load /org/gnome/settings-daemon/ < $dotfile_dir_absolute_path/dconf/settings-daemon.dconf
dconf load /org/gnome/shell/ < $dotfile_dir_absolute_path/dconf/shell.dconf
dconf load /org/gnome/terminal/ < $dotfile_dir_absolute_path/dconf/terminal.dconf
dconf load /org/gnome/desktop/ < $dotfile_dir_absolute_path/dconf/desktop.dconf

source "$HOME/.profile"

# PHP
composer global install
symfony-autocomplete composer | sudo tee /etc/bash_completion.d/composer

# nodejs
n latest
npm completion > npm
sudo mv npm /etc/bash_completion.d/npm

npm install -g \
    babel-cli \
    browser-sync \
    eslint \
    http-server \
    npm-check \
    nsp \
    pkgcount \
    stylelint \
    ttystudio \
    types-checker \
    #node-inspector

#apm install --packages-file $dotfile_dir_absolute_path/.atom/atom-package.txt
