" Set leader key to space
let mapleader = " "

call plug#begin()

Plug 'scottmckendry/cyberdream.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': 'v0.1.9' }
Plug 'hrsh7th/nvim-cmp'          " Completion engine
Plug 'hrsh7th/cmp-nvim-lsp'      " LSP source for nvim-cmp
Plug 'L3MON4D3/LuaSnip'          " Snippet engine (optional but recommended)
Plug 'saadparwaiz1/cmp_luasnip'  " Snippet completion source
Plug 'windwp/nvim-autopairs'

call plug#end()

lua <<EOF
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.o.background = "dark"
vim.cmd.colorscheme "cyberdream"

require("treesitter")
require("autopairs")
require("mason_cfg")
EOF

" Source keymaps
source ~/.config/nvim/keymaps.vim
