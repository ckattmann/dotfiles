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
" Ctrl-n for another cursor on *:
Plugin 'terryma/vim-multiple-cursors'
" Select based on indentation with ai, ii, aI:
Plugin 'michaeljsmith/vim-indent-object'
" Plugin for automatic Black on save:
" Plugin 'psf/black'
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
" autocmd BufWritePre *.py execute ':Black'



"" Shortcuts with <leader>
"" =======================

" Set leader to ,
let mapleader = ","

" s: Set Spelling
nnoremap <leader>s :set spell!<CR>

" n: Un-highlight
nmap <leader>n :nohl<CR>

" g: Start Goyo
nnoremap <leader>g :Goyo<CR>

" 6: Highlight current word and all similar words
nnoremap <leader>6 *N

" u: Underline current comment line with ===
nnoremap <leader>u yypwv$r=
