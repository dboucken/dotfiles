---------------------------------------------------------------------------------------------------
-- GENERAL SETTINGS
---------------------------------------------------------------------------------------------------
vim.o.autowriteall = true             -- auto save files on certain events
vim.o.completeopt = 'longest,menuone' -- better insert mode auto completion
vim.o.expandtab = true                -- tabs are spaces
vim.o.ignorecase = true               -- ignore case when searching lowercase
vim.o.inccommand = 'nosplit'          -- shows interactive results for substitute-like commands
vim.o.list = true                     -- show trailing whitespace
vim.o.listchars = 'tab:>\\ ,trail:-'  -- show tabs and trailing white space when list is enabled
vim.o.mouse = 'a'                     -- enable mouse support
vim.o.shiftround = true               -- round to multiple of shift width when adjusting indentation
vim.o.shiftwidth = 4                  -- number of spaces for each step of auto indent
vim.o.smartcase = true                -- don't ignore case when inserting uppercase characters in search
vim.o.softtabstop = 4                 -- number of spaces per tab when editing
vim.o.swapfile = false                -- disable swap files
vim.o.tabstop = 4                     -- number of visual spaces per tab
vim.o.timeout = false                 -- never timeout on mappings
vim.o.ttimeout = true                 -- timeout on key codes
vim.o.ttimeoutlen = 200               -- timeout length on key codes
vim.o.undofile = true                 -- persistent undo history
vim.o.updatetime = 100                -- milliseconds VIM will wait to trigger the CursorHold event
vim.o.visualbell = true               -- use visual bell instead of beeping
vim.o.wildmode = 'longest,full'       -- first complete to the longest match, then to the first full one
vim.o.wrap = false                    -- don't wrap

---------------------------------------------------------------------------------------------------
-- AUTO COMMANDS
---------------------------------------------------------------------------------------------------
vim.cmd('augroup custom_autocommands')

-- clear all auto commands in this group
vim.cmd('autocmd!')

-- check if the file has changed outside of Vim when the cursor has moved
vim.cmd('autocmd CursorHold * silent! checktime')

-- enable spell checking by default for git commit files
vim.cmd('autocmd Filetype gitcommit setlocal spell')

-- enable spell checking and show hidden chars for markdown files by default
vim.cmd('autocmd Filetype markdown setlocal spell')
vim.cmd('autocmd Filetype markdown setlocal list')
vim.cmd('autocmd Filetype markdown setlocal textwidth=100')

-- don't show hidden characters in man pages
vim.cmd('autocmd Filetype man setlocal nolist')

-- open quickfix and git commit window always at the bottom and with the full width of the screen
vim.cmd('autocmd FileType qf,gitcommit wincmd J')

-- open quickfix/location list when it is populated
vim.cmd('autocmd QuickFixCmdPost [^l]* cwindow')
vim.cmd('autocmd QuickFixCmdPost    l* lwindow')
vim.cmd('autocmd VimEnter            * cwindow')
vim.cmd('augroup END')

---------------------------------------------------------------------------------------------------
-- ABBREVIATIONS
---------------------------------------------------------------------------------------------------
-- insert a C style DO_NOT_COMMIT comment
vim.cmd 'iabbrev DO /* DO_NOT_COMMIT: */<left><left><left>'

-- insert a C style to do comment
vim.cmd 'iabbrev TODO /* TODO dboucken: */<left><left><left>'

---------------------------------------------------------------------------------------------------
-- CUSTOM KEY MAPPINGS
---------------------------------------------------------------------------------------------------
-- remap escape in insert mode
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true })

-- remap : in normal mode
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })

-- auto expand curly brackets in insert mode
vim.api.nvim_set_keymap('i', '{<cr>', '{<cr>}<Esc>O', { noremap = true })

-- keep the found words in the middle of screen when jumping to the next/previous
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', { noremap = true })

-- allow saving of files as sudo when I forgot to start vim using sudo.
vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee > /dev/null %', { noremap = true })

---------------------------------------------------------------------------------------------------
-- LEADER KEY MAPPINGS
---------------------------------------------------------------------------------------------------
-- use space as leader
vim.g.mapleader = ' '

-- clear search highlight
vim.api.nvim_set_keymap('n', '<leader>hl', ':nohlsearch<cr>', { noremap = true })

-- run the macro in register q
vim.api.nvim_set_keymap('n', '<Leader><leader>', '@q', { noremap = true })

-- delete trailing white space on a line
vim.api.nvim_set_keymap('n', '<Leader>dd', ':s/\\s\\+$//e<cr>', { noremap = true })

-- quickly open init.lua
vim.api.nvim_set_keymap('n', '<Leader>ev', ':vertical split $MYVIMRC<cr>', { noremap = true })

-- grep the word under the cursor recursively in the directory of the current file
vim.api.nvim_set_keymap('n', '<Leader>gd', ':grep! -w <c-r><c-w> %:p:h<cr>', { noremap = true })

-- grep the word under the cursor recursively, don't return to be able to pass options and dirs
vim.api.nvim_set_keymap('n', '<Leader>gw', ':grep! -w <c-r><c-w> ', { noremap = true })

-- async make
vim.api.nvim_set_keymap('n', '<Leader>mm', ':Make ', { noremap = true })

-- replace the word under the cursor with the last yanked (not deleted) text
vim.api.nvim_set_keymap('n', '<Leader>pp', 'ciw<C-r>0<Esc>', { noremap = true })

-- open/close the quickfix list window
vim.api.nvim_set_keymap('n', '<Leader>qo', ':copen<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>qc', ':cclose<cr>', { noremap = true })

-- remap <c-w> to something easier
vim.api.nvim_set_keymap('n', '<Leader>w', '<c-w>', { noremap = true })

---------------------------------------------------------------------------------------------------
-- PLUGINS
---------------------------------------------------------------------------------------------------
require('packer').startup(function()
    use 'folke/tokyonight.nvim'
    use 'neovim/nvim-lspconfig'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-unimpaired'
    use 'wbthomason/packer.nvim'
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'rust-lang/rust.vim', ft = {'rust'}}
    use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
end)

---------------------------------------------------------------------------------------------------
-- PLUGIN SETTINGS
---------------------------------------------------------------------------------------------------
-- gitsigns
require('gitsigns').setup()

-- treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- lsp
local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

nvim_lsp.ccls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    init_options = {
        cache = {
            directory = "/tmp/cache/ccls",
            index = {
                threads = 1,
            },
        },
    },
}

nvim_lsp.gopls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {'gopls', '--remote=auto'},
}

nvim_lsp.rust_analyzer.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.pylsp.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

-- ripgrep
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'

-- colorscheme
vim.opt.background = 'light'
vim.cmd('colorscheme tokyonight')
