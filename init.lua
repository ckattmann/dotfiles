vim.opt.ttyfast = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.number = true
vim.opt.cc = '100'

vim.opt.mouse = 'a'

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Plugins:
-----------

-- Set special venv path with black installed
vim.g.python3_host_prog = os.getenv("HOME") .. '/.local/venv/nvim/bin/python'

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/site/plugged')
Plug 'kien/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'neovim/nvim-lspconfig'
Plug 'tpope/vim-commentary'
Plug 'psf/black'
Plug 'morhetz/gruvbox'
-- Show Indentation Lines :
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
vim.call('plug#end')

-- Apply colorscheme:
vim.cmd("autocmd vimenter * ++nested colorscheme gruvbox")

-- Use fancy fonts with powerline
vim.g.airline_powerline_fonts = 1

vim.cmd("autocmd BufWritePre *.py execute ':Black'")

vim.g.startify_bookmarks = {{['i'] ='~/.config/nvim/init.lua'}}
-- autocmd BufNewFile,BufRead *.service* set ft=systemd
--
-- WSL yank support:
vim.cmd([[
    let s:clip = '/mnt/c/Windows/System32/clip.exe'
    if executable(s:clip)
        augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
    endif
]])


vim.keymap.set('n','<F1>', '<nop>')
vim.keymap.set('n','<C-S>', ':w<CR>')
vim.keymap.set('i','<C-S>', '<Esc>:w<CR>')


-- Mapleader commands:
----------------------
vim.g.mapleader = ','
function leader(key, command) vim.keymap.set('n', '<leader>' .. key, command) end
leader('n', ':nohl<CR>')  -- Un-highlight
leader('6', '*N')  -- Highlight all occurences of current word
leader('p', '"0p')  -- Paste from 0 register for multiple pastes of the same copied text
leader('u', 'yypwv$r=')  -- fancy underline with ========


-- Commands Keys:
-----------------
function command(lhs, rhs) vim.api.nvim_create_user_command(lhs, rhs, {}) end
command('W','w')
command('Q','q')
command('Wq','wq')
command('WQ','wq')

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "c", "lua", "rust" },
  sync_install = false,
  auto_install = true,

}

-- LSP Configuration:
---------------------

local opts = { noremap=true, silent=true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
end

-- this part is telling Neovim to use the lsp server
local servers = { 'pyright', 'tsserver', 'jdtls' }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        flags = {
          debounce_text_changes = 50,
        }
    }
end

vim.opt.signcolumn = 'number'
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end
