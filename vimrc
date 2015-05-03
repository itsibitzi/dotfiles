
" Show line numbers.
set nu

" Font
set guifont=Liberation\ Mono\ for\ Powerline
"set guifont=Menlo\ for\ Powerline

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

" Bundle loading requirements
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on
Bundle 'gmarik/vundle'

" Nerd tree config
Bundle "scrooloose/nerdtree"
Bundle 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_opne_on_on_gui_startup = 1

" Pretty status bar
Bundle 'itchyny/lightline.vim'
let g:lightline = {
            \ 'colorscheme': 'wombat',
            \ 'component': {
            \   'readonly': '%{&readonly?"⭤":""}',
            \ },
            \ 'separator': { 'left': '⮀', 'right': '⮂' },
            \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
            \ }

" You Complete Me
" Make me an IDE, lots of options
" Bundle 'Valloric/YouCompleteMe'
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_confirm_extra_conf = 0
" let g:ycm_show_diagnostics_ui = 1
" nnoremap <F5> :YccmForceCompileAndDiagnostics<CR>

" Color schemes
Bundle 'flazz/vim-colorschemes'

" Rust syntax highlighting
Bundle "wting/rust.vim"

Bundle 'digitaltoad/vim-jade'

" It's important this is "GUIEnter" as opposed to "VimEnter" - if it's at
" VimEnter it clobbers LightLine's status bar coloring.
autocmd GUIEnter * colorscheme candycode

" Rust compilation
map <F5> <esc>:!cargo build<CR>
map <S-F5> <esc>:!cargo build --release<CR>

Bundle 'phildawes/racer'
set hidden
let g:racer_cmd = "/home/sam/.vim/bundle/racer/target/release/racer"

function! MakeDirectory()
    let dir_name = input('Create new directory: ')
    if dir_name != ''
        exec ':!mkdir ' . dir_name
        redraw!
    endif
endfunction
map <Leader>d :call MakeDirectory()<cr>
