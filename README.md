## Installation

**WARNING**
copy bootstrap.sh.dist into bootstrap.sh and modify [home-dir-absolute-path] and [dotfile-dir-absolute-path]

```bash
git clone https://github.com/romainprignon/dotfiles.git
cd dotfiles
./bootstrap.sh
```
On windows :
mklink /H C:\Users\Smith\.vimrc C:\Users\Smith\workspace\dotfiles\.vimrc

**editorconfig**
if you want to use a global editorconfig, rename .my_editorconfig into .editorconfig_
