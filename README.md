## Installation

```bash
git clone https://github.com/romainprignon/dotfiles.git
source ./dotfiles/bootstrap.sh
```
TODO
====

plugin:
SnipMate
Ctrl-P
Surround
Fugitive
Vim-Sauce
Syntastic
airblade/vim-gitgutter
    let g:gitgutter_enabled = 1
    let g:gitgutter_eager = 0
    let g:gitgutter_sign_column_always = 1
    highlight clear SignColumn
surround
autoclose
terryma/vim-multiple-cursors
phpcomplete
PIV
Valloric/YouCompleteMe
Shougo/neocomplcache.vim
scrooloose/nerdcommenter

avoir:
m2mdas/phpcomplete-extended-symfony
vim-symfony
Snipmate
NerdCommenter
NerdTree
SuperTab
Fugitive
DelimitMate
Matchit
CheckSyntax
Surrounding
AutoCloseTag
AutoTag
vim-php-namespace


set wrap                " Wrap lines ?

filetype indent on      " permet indentation specifique a l'extension du fichier


" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.php :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()






set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set ruler                       " show the cursor position all the time
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set backspace=indent,eol,start  " make that backspace key work the way it should
set nocompatible                " vi compatible is LAME
set background=dark             " Use colours that work well on a dark background (Console is usually black)
set showmode                    " show the current mode
syntax on                       " turn syntax highlighting on by default

" Show EOL type and last modified timestamp, right after the filename
set statusline=%<%F%h%m%r\ [%{&ff}]\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})%=%l,%c%V\ %P
