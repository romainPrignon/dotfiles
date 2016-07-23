set dotfile_dir_absolute_path="C:\Users\Romain\workspace\romainprignon\dotfiles"
set home_dir_absolute_path="C:\Users\Romain"

cd %home_dir_absolute_path%

mkdir .composer
mkdir .ssh

git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1

rmdir %home_dir_absolute_path%\.atom
del %home_dir_absolute_path%\.composer\composer.json
rmdir %home_dir_absolute_path%\scripts
del %home_dir_absolute_path%\.gitattributes
del %home_dir_absolute_path%\.gitconfig
del %home_dir_absolute_path%\.gitignore
del %home_dir_absolute_path%\.vimrc
del %home_dir_absolute_path%\.aliases
del %home_dir_absolute_path%\.bashrc
del %home_dir_absolute_path%\.exports
del %home_dir_absolute_path%\.exports_windows
del %home_dir_absolute_path%\.functions
del %home_dir_absolute_path%\.bash-git-prompt\themes\Single_line_Ubuntu_Romain.bgptheme
del %home_dir_absolute_path%\.inputrc
del %home_dir_absolute_path%\.profile
del %home_dir_absolute_path%\.ssh\config

mklink /D %home_dir_absolute_path%\.atom %dotfile_dir_absolute_path%\.atom
mklink /H %home_dir_absolute_path%\.composer\composer.json %dotfile_dir_absolute_path%\.composer\composer.json
mklink /D %home_dir_absolute_path%\scripts %dotfile_dir_absolute_path%\scripts
mklink /H %home_dir_absolute_path%\.gitattributes %dotfile_dir_absolute_path%\.gitattributes
mklink /H %home_dir_absolute_path%\.gitconfig %dotfile_dir_absolute_path%\.gitconfig
mklink /H %home_dir_absolute_path%\.gitignore %dotfile_dir_absolute_path%\.gitignore
mklink /H %home_dir_absolute_path%\.vimrc %dotfile_dir_absolute_path%\.vimrc
mklink /H %home_dir_absolute_path%\.aliases %dotfile_dir_absolute_path%\.aliases
mklink /H %home_dir_absolute_path%\.bashrc %dotfile_dir_absolute_path%\.bashrc
mklink /H %home_dir_absolute_path%\.exports %dotfile_dir_absolute_path%\.exports
mklink /H %home_dir_absolute_path%\.exports_windows %dotfile_dir_absolute_path%\.exports_windows
mklink /H %home_dir_absolute_path%\.functions %dotfile_dir_absolute_path%\.functions
mklink /H %home_dir_absolute_path%\.bash-git-prompt\themes\Single_line_Ubuntu_Romain.bgptheme %dotfile_dir_absolute_path%\Single_line_Ubuntu_Romain.bgptheme
mklink /H %home_dir_absolute_path%\.inputrc %dotfile_dir_absolute_path%\.inputrc
mklink /H %home_dir_absolute_path%\.profile %dotfile_dir_absolute_path%\.profile
mklink /H %home_dir_absolute_path%\.ssh\config %dotfile_dir_absolute_path%\.ssh\config

mklink /H "%home_dir_absolute_path%\AppData\Roaming\Sublime Text 3\Packages\User\Default (Windows).sublime-keymap" "%dotfile_dir_absolute_path%\subl\Default (Windows).sublime-keymap"
mklink /H "%home_dir_absolute_path%\AppData\Roaming\Sublime Text 3\Packages\User\Preferences.sublime-settings" "%dotfile_dir_absolute_path%\subl\Preferences.sublime-settings"
mklink /H "%home_dir_absolute_path%\AppData\Roaming\Sublime Text 3\Packages\User\Package Control.sublime-settings" "%dotfile_dir_absolute_path%\subl\Package Control.sublime-settings"
