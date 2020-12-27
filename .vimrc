set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Comment out and in with gc<movement>:
Plugin 'tpope/vim-commentary'
" Hide all UI with :Goyo:
Plugin 'junegunn/goyo.vim'
" Prettier Status line:
Plugin 'vim-airline/vim-airline'
" Mouse support and nicer cursors:
Plugin 'wincent/terminus'
" Fuzzy file search with C-P:
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin for automatic Black on save:
Plugin 'psf/black'
" Ctrl-n for another cursor on *:
Plugin 'terryma/vim-multiple-cursors'

call vundle#end()


syntax on
filetype plugin indent on

" Show line numbers
set number

" Show file stats
set ruler

" Faster terminal rendering
set ttyfast

set smartcase

" Highlight search results:
set hlsearch

" Linenumbers in gray
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=None gui=NONE guifg=DarkGrey guibg=NONE
"
" Highlight in DarkGray, which is more visible in darkmode
highlight Visual guifg=LightGray ctermbg=DarkGray gui=none
highlight SpellBad cterm=underline ctermbg=DarkRed

set wrap
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab



"" Key bindings
"" ============

" Disable F1
nmap <F1> <nop>
"
" Move up and down editor lines, not file lines
nnoremap j gj
nnoremap k gk

" Save also with :W
command W w
command Wq wq



"" PLUGIN SETTINGS
"" ===============

" Set Goyo to be a bit wider:
let g:goyo_width=100

" Auto black on save for Python files
autocmd BufWritePre *.py execute ':Black'



"" Shortcuts with <leader>
"" =======================

" Set leader to ,
let mapleader = ","

" Spelling with ,s
nnoremap <leader>s :set spell!<CR>

" Un-highlight with ,n:
nmap <leader>n :nohl<CR>

" Start Goyo with ,g:
nnoremap <leader>g :Goyo<CR>
