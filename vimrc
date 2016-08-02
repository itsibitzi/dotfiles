" Show line numbers.
set nu

" Font
set guifont=Liberation\ Mono\ for\ Powerline
"set guifont=Menlo\ for\ Powerline

set noswapfile

" Hide the scroll bars in gvim
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" Open tags in new tab
nnoremap <C-Space> <C-w><C-]><C-w>T

" Reload externally changed files
set autoread

" Rust file type stuff
filetype on
au BufNewFile,BufRead *.rs set filetype=rust
au BufNewFile,BufRead *.jade set filetype=jade

" Remove trailing whitespace on save
au BufWritePre * :%s/\s\+$//e
au BufWritePre * :retab

" Format indent
nnoremap <C-f> mzgg=G`z

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Tab options
set expandtab
set tabstop=4
set shiftwidth=4

" Tab movement options
nmap <S-k> gt
nmap <S-j> gT

" Disable ex mode
nnoremap Q <nop>

" Folding options
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Highlight code.
syntax on

" Nicer keyboard shortcuts for moving between splits.
nmap <C-h> <C-w><C-h>
nmap <C-j> <C-w><C-j>
nmap <C-k> <C-w><C-k>
nmap <C-l> <C-w><C-l>

" Make it faster to save
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Move into braces etc.
inoremap ' ''<Left>
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "'"

inoremap " ""<Left>
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\""

inoremap ( ()<Left>
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap <<Space> <<Space>
inoremap << <<
inoremap < <><Left>
inoremap <expr> > strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"

inoremap [ []<Left>
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

inoremap { {}<Left>
" Step over already closed braces
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
" When return is pressed and we're inside a "{}" then push down the second
" brace an extra newline.
inoremap <expr> <CR> strpart(getline('.'), col('.')-1, 1) == "}" ? "\<CR>\<CR>\<Up>\<Tab>" : "\<CR>"

" Quickly put a semicolon or comma at the end of a line
inoremap ,, <End>,
inoremap ;; <End>;

" Encoding options.
set encoding=utf-8
scriptencoding utf-8

" Plugin loading requirements
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Nerd tree config
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_opne_on_on_gui_startup = 1

" Pretty status bar
Plugin 'itchyny/lightline.vim'
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'component': {
            \   'readonly': '%{&readonly?"⭤":""}',
            \ },
            \ 'separator': { 'left': '⮀', 'right': '⮂' },
            \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
            \ }

" Color schemes
Plugin 'flazz/vim-colorschemes'

" Rust syntax highlighting
Plugin 'wting/rust.vim'

" It's important this is "GUIEnter" as opposed to "VimEnter" - if it's at
" VimEnter it clobbers LightLine's status bar coloring.
autocmd GUIEnter * colorscheme molokai

Plugin 'Valloric/YouCompleteMe'
let g:ycm_rust_src_path = '/home/sam/.rustsrc/src'

" Rust compilation
map <F5> <esc>:!cargo build<CR>
map <S-F5> <esc>:!cargo build --release<CR>

call vundle#end()
filetype plugin indent on

function! MakeDirectory()
    let dir_name = input('Create new directory: ')
    if dir_name != ''
        exec ':!mkdir ' . dir_name
        redraw!
    endif
endfunction
map <Leader>d :call MakeDirectory()<cr>

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>n :call RenameFile()<cr>
