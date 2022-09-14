scriptencoding utf-8

lua require('bootstrap_packer')
lua require('nvim-tree-config')
lua require('nvim-treesitter-config')
lua require('rust-tools-config')
lua require('telescope-config')

filetype plugin indent on

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

if has('persistent_undo')
    set undodir=~/.vim/undodir
    set undofile
endif

autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe 'normal! g`"' | endif

augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

set number relativenumber
set incsearch
set hlsearch
set noswapfile
set nowrap
set ruler
set laststatus=2
set encoding=utf-8
set hidden

" Reload externally changed files
set autoread

" Rust file type stuff
filetype on
au BufNewFile,BufRead *.rs set filetype=rust

" Remove trailing whitespace on save
au BufWritePre * :%s/\s\+$//e
au BufWritePre * :retab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Disable ex mode
nnoremap Q <nop>

" Tab options
set expandtab
set tabstop=4
set shiftwidth=4

" Highlight code.
syntax on

" Quickly put a semicolon or comma at the end of a line
inoremap ,, <End>,
inoremap ;; <End>;

" Keep text selected when indenting
vnoremap < <gv
vnoremap > >gv

