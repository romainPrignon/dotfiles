#!/usr/bin/env bash

$dotfile_dir_absolute_path="/home/romainprignon/workspace/romainprignon/dotfiles"
$home_dir_absolute_path="/home/romainprignon"

cd $home_dir_absolute_path

mkdir .composer
mkdir .ssh

git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1
cp $dotfile_dir_absolute_path/Single_line_Ubuntu_Romain.bgptheme .bash-git-prompt/themes/Single_line_Ubuntu_Romain.bgptheme

ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.atom /home/romainprignon/.atom
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.composer/composer.json /home/romainprignon/.composer/composer.json
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/scripts /home/romainprignon/scripts
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.gitattributes /home/romainprignon/.gitattributes
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.gitconfig /home/romainprignon/.gitconfig
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.gitignore /home/romainprignon/.gitignore
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.vimrc /home/romainprignon/.vimrc
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.aliases /home/romainprignon/.aliases
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.bashrc /home/romainprignon/.bashrc
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.exports /home/romainprignon/.exports
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.functions /home/romainprignon/.functions
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/Single_line_Ubuntu_Romain.bgptheme /home/romainprignon/.bash-git-prompt/themes/Single_line_Ubuntu_Romain.bgptheme
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.inputrc /home/romainprignon/.inputrc
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.profile /home/romainprignon/.profile
ln -sf /home/romainprignon/workspace/romainprignon/dotfiles/.ssh/config /home/romainprignon/.ssh/config
