scriptencoding utf-8

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
    Plugin 'gmarik/vundle'

    Plugin 'scrooloose/nerdtree'

    Plugin 'jistr/vim-nerdtree-tabs'
        let g:nerdtree_tabs_open_on_console_startup = 1
        let g:nerdtree_tabs_open_on_gui_startup = 1
        let g:nerdtree_tabs_smart_startup_focus = 2
        let g:nerdtree_tabs_focus_on_files = 1
        let g:nerdtree_tabs_autofind = 1

    Plugin 'flazz/vim-colorschemes'
        set t_Co=256
        autocmd VimEnter * colorscheme molokai

    Plugin 'wting/rust.vim'

    Plugin 'derekwyatt/vim-scala'

    Plugin 'mileszs/ack.vim'

    Plugin 'ctrlpvim/ctrlp.vim'
        let g:ctrlp_cmd = 'CtrlP'
        let g:ctrlp_show_hidden = 1
        let g:ctrlp_working_path_mode = 'ra'
        let g:ctrlp_follow_symlinks = 1
        let g:ctrlp_map = '<c-p>'
        let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

call vundle#end()

filetype plugin indent on

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

set nu
set incsearch
set hlsearch
set noswapfile
set nowrap
set ruler
set hidden
set laststatus=2
set encoding=utf-8

" Hide the scroll bars in {m,g}vim
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" Reload externally changed files
set autoread

" Rust file type stuff
filetype on
au BufNewFile,BufRead *.rs set filetype=rust
au BufNewFile,BufRead *.scala set filetype=scala
au BufNewFile,BufRead *.sc set filetype=scala
au BufNewFile,BufRead *.sbt set filetype=scala

" Remove trailing whitespace on save
au BufWritePre * :%s/\s\+$//e
au BufWritePre * :retab

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

" Move into pairs and step over completed pairs
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
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

" When return is pressed and we're inside a "{}" then push down the second
" brace an extra newline.
inoremap <expr> <CR> strpart(getline('.'), col('.')-1, 1) == "}" ? "\<CR>\<CR>\<Up>\<Tab>" : "\<CR>"

" Quickly put a semicolon or comma at the end of a line
inoremap ,, <End>,
inoremap ;; <End>;

" Pretty flakey on OSX, has the habit of blowing away files entirely
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

function! MakeDirectory()
    let dir_name = input('Create new directory: ')
    if dir_name != ''
        exec ':!mkdir ' . dir_name
        redraw!
    endif
endfunction
map <Leader>d :call MakeDirectory()<cr>
