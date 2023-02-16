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
" Show Indentation Lines :
Plugin 'Yggdroot/indentLine'
" JSON Formatter, basically just to fix indentLine's behaviour in json files:
Plugin 'elzr/vim-json'
Plugin 'digitaltoad/vim-pug'
" Gruv colorscheme: (https://github.com/morhetz/gruvbox)
Plugin 'morhetz/gruvbox'
" Select based on indentation with ai, ii, aI:
Plugin 'michaeljsmith/vim-indent-object'
" Plugin for automatic Black on save:
Plugin 'psf/black'
call vundle#end()


syntax on
filetype plugin indent on


"" GENERAL SETTINGS
"" ================

" autocmd vimenter * ++nested colorscheme gruvbox
colorscheme desert

set background=dark
" colorscheme nord

" disable bell:
set noerrorbells visualbell t_vb=

" Show line numbers:
set number

" Faster terminal rendering:
set ttyfast

" When searching, only be case-sensitive when there is a capital letter:
set smartcase

" Highlight search results:
set hlsearch

" Wrap long lines:
set wrap

" Tab settings:
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" With :vsp, split the new window at the right
set splitright

" Linenumbers in gray:
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=None gui=NONE guifg=DarkGrey guibg=NONE

" Highlight in DarkGray, which is more visible in darkmode:
highlight Visual guifg=LightGray ctermbg=DarkGray gui=none
highlight SpellBad cterm=underline ctermbg=DarkRed

" YAML files get different tabstop settings:
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" No fancy font glyphs in latex:
let g:tex_conceal = ''

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif


"" Key bindings
"" ============

" Disable F1
nmap <F1> <nop>

" Move up and down editor lines, not file lines
nnoremap j gj
nnoremap k gk

" Aliases for fat fingers:
cnoreabbrev X x
command W w
command Wq wq
command Q q
command WQ wq

" CTRL-S for saving (this only works when its unset from pause)
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

"" PLUGIN SETTINGS
"" ===============

let g:airline_powerline_fonts = 1

" Dont hide anything in json files
let g:vim_json_syntax_conceal = 0

" Setup indentLine to show a more subtle char:
let g:indentLine_char = '⦙'
let g:indentLine_color_term = 239

" Set Goyo to be a bit wider:
let g:goyo_width = 100

" Auto black on save for Python files
" autocmd BufWritePre *.py execute ':Black'

let g:black_linelength = 100

"" SHORTCUTS WITH <LEADER>
"" =======================

" Set leader to ,
let mapleader = ","

" ,s -> Set Spelling
nnoremap <leader>s :set spell!<CR>

" ,n -> Un-highlight
nmap <leader>n :nohl<CR>

" ,g -> Start Goyo
nnoremap <leader>g :Goyo<CR>

" ,6 -> Highlight current word and all similar words
nnoremap <leader>6 *N

" ,p -> Paste from 0 register for multiple pastes of the same copied text:
nnoremap <leader>p "0p

" ,r -> Run current buffer with python
nnoremap <leader>r :w<CR>:!python %<CR>

" ,u -> Underline current comment line with ===
nnoremap <leader>u yypwv$r=
