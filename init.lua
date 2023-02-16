vim.opt.ttyfast = true


vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.number = true

vim.opt.mouse = 'a'

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.omnifunc = 'syntaxcomplete#Complete'

-- Commands Mappings:
---------------------
function command(lhs, rhs) vim.api.nvim_create_user_command(lhs, rhs, {}) end

command('W', 'w')
command('Q', 'q')
command('Wq', 'wq')
command('WQ', 'wq')


-- Autocommands
---------------

-- Catchall group for auto-clearing
vim.api.nvim_create_augroup("group", { clear = true })

vim.api.nvim_create_autocmd(
    "Filetype",
    { pattern = "*.htm*", command = "set omnifunc = htmlcomplete#CompleteTags", group = 'group' }
)

vim.api.nvim_create_autocmd(
    { 'BufNewFile', 'BufRead' },
    { pattern = '*.service', command = 'set ft=systemd', group = 'group' }
)


-- Plugins:
-----------

-- Set special venv path with black installed
vim.g.python3_host_prog = os.getenv("HOME") .. '/.local/venv/nvim/bin/python'

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/site/plugged')

-- Colorscheme:
Plug 'morhetz/gruvbox'
-- https://github.com/rebelot/kanagawa.nvim
Plug "rebelot/kanagawa.nvim"

Plug 'nvim-lualine/lualine.nvim'

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'

Plug 'kien/ctrlp.vim'

Plug 'Yggdroot/indentLine' -- show Indentation Lines:
Plug 'tpope/vim-commentary'
Plug 'psf/black'
Plug 'digitaltoad/vim-pug'

Plug 'mhinz/vim-startify'
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

Plug 'nvim-lua/plenary.nvim' -- Required for telescope: https://github.com/nvim-lua/plenary.nvim
Plug 'nvim-telescope/telescope.nvim'
Plug "natecraddock/telescope-zf-native.nvim"

-- Tag Autocompletion
Plug  'windwp/nvim-ts-autotag'

-- Char as colorchar line: https://github.com/lukas-reineke/virt-column.nvim:
Plug 'lukas-reineke/virt-column.nvim'

-- File tree with <C-T>:
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'

-- Autocompletion with https://github.com/hrsh7th/nvim-cmp:
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

-- Snippets with https://github.com/sirver/ultisnips:
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug('tzachar/cmp-tabnine', { ['do'] = './install.sh' })
Plug 'onsails/lspkind.nvim' -- https://github.com/onsails/lspkind.nvim

Plug 'junegunn/goyo.vim'

Plug '/home/kipfer/projects/hajimeru.nvim'

vim.call('plug#end')


-- Colorscheme:
-- require('kanagawa').setup({ commentStyle = { italic = true } })
-- vim.cmd('colorscheme gruvbox')
-- vim.cmd("colorscheme kanagawa")
vim.api.nvim_create_autocmd(
    { 'VimEnter' },
    { pattern = '*', command = 'colorscheme gruvbox', group = 'group' }
)


-- Virt-columns Configuration
require("virt-column").setup { char = "⦙", virtcolumn = '120' }
vim.cmd([[autocmd ColorScheme * highlight clear ColorColumn]])


-- vim.cmd("autocmd BufWritePre *.py execute ':Black'")
vim.api.nvim_create_autocmd(
    'BufWritePre',
    { pattern = '*.py', command = 'Black', group = 'group' }
)

-- Startify configuration:
vim.g.startify_bookmarks = { { ['i'] = '~/.config/nvim/init.lua' } }
vim.g.startify_files_number = 5

-- nvim-tree configuration:
require("nvim-tree").setup()

-- Ultisnips configuration:
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsListSnippets = "<F3>"

-- Treesitter configuration:
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "python", "c", "lua", "rust", "svelte" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    }
    -- autotag = {enabled = true,}
}
require('nvim-ts-autotag').setup()


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


-- Mapleader commands:
----------------------
vim.g.mapleader = ','
function leader(key, command) vim.keymap.set('n', '<leader>' .. key, command) end

leader('n', ':nohl<CR>') -- Un-highlight
leader('6', '*N') -- Highlight all occurences of current word
leader('p', '"0p') -- Paste from 0 register for multiple pastes of the same copied text
leader('u', 'yypwv$r-') -- fancy underline with ------------
leader('s', ':Startify<CR>') -- startify
leader('g', ':Goyo 120<CR>')


vim.keymap.set('n', '<F1>', '<nop>')
vim.keymap.set('n', '<C-S>', ':w<CR>')
vim.keymap.set('i', '<C-S>', '<Esc>:w<CR>')
vim.keymap.set({ 'i', 'n' }, '<C-X>', '<Esc>:wq<CR>')
vim.keymap.set('n', '<C-T>', ':NvimTreeOpen<CR>')
vim.keymap.set('i', '<C-T>', '<Esc>:NvimTreeOpen<CR>')


-- Telescope commands:
----------------------
require("telescope").load_extension("zf-native")
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- Lualine
-- -------
-- https://github.com/nvim-lualine/lualine.nvim
-- vim.cmd('highlight StatusLine ctermbg=NONE cterm=NONE')
local colors = {
    blue      = '#80a0ff',
    cyan      = '#79dac8',
    black     = '#080808',
    white     = '#c6c6c6',
    red       = '#FF6B0F',
    violet    = '#d183e8',
    grey      = '#303030',
    greygreen = '#91AE7E'
}
local configure_lualine = function()
    local custom_gruvbox = require('lualine.themes.gruvbox_dark')
    custom_gruvbox.normal.a.bg = colors.greygreen
    custom_gruvbox.insert.a.bg = colors.red
    custom_gruvbox.insert.c.bg = nil

    require('lualine').setup {
        options = {
            theme = custom_gruvbox,
            component_separators = '|',
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = {
                { 'mode', separator = { left = '', right = '' }, right_padding = 1 },
            },
            lualine_b = { 'filename' },
            lualine_c = { 'diagnostics' },
            lualine_x = {},
            lualine_y = { 'filetype' },
            lualine_z = {
                { 'location', separator = { left = '' }, left_padding = 0 },
                { 'progress', separator = { right = '' }, left_padding = 0 },
            },
        },
        inactive_sections = {
            lualine_a = { 'filename' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'location' },
        },
        tabline = {
            lualine_a = { 'buffers' }
        },
        extensions = {},
    }
end
-- This is really dumb, but it fixes the issue with light outer borders:
vim.api.nvim_create_autocmd(
    { 'VimEnter', 'BufEnter' },
    { pattern = '*', callback = configure_lualine, group = 'group' }
)

-- LSP Configuration:
---------------------

local opts = { noremap = true, silent = true }

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

    vim.api.nvim_create_autocmd(
        "BufWritePre",
        { pattern = "*.ts", callback = function() vim.lsp.buf.format({ async = true }) end, group = 'group' }
    )

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()

local servers = {
    pyright = {},
    tsserver = {},
    jdtls = {},
    tsserver = {},
}

-- for _, lsp in pairs(servers) do
--     require('lspconfig')[lsp].setup {
--         on_attach = on_attach,
--         flags = {
--           debounce_text_changes = 50,
--         },
--         capabilities = capabilities
--     }
-- end


-- Mason configuration:
require("mason").setup()
require('mason-lspconfig').setup({
    automatic_installation = true
})
require('mason-lspconfig').setup_handlers({
    function(server_name)
        require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        })
    end
})
require('mason-tool-installer').setup({
    auto_update = true
})

-- Hint Chars configuration:
vim.opt.signcolumn = 'number'
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- nvim-cmp configuration:
--------------------------

require('cmp_tabnine.config'):setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = '..',
    show_prediction_strength = true
})


vim.opt.completeopt = { 'menu', 'menuone', 'preview' }


local cmp = require('cmp')
cmp.setup({
    completion = {
        completeopt = 'menu,menuone',
    },
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'cmp_tabnine' }
    }),
    formatting = {
        format = require('lspkind').cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            before = function(entry, vim_item)
                if entry.source.name == 'cmp_tabnine' then
                    vim_item.kind = '🧠'
                end
                return vim_item
            end
        })
    },
    experimental = {
        ghost_text = true
    }
})
