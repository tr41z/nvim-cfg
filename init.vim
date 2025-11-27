" Set leader key to space
let mapleader = " "

call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': 'v0.1.9' }

call plug#end()

" Source keymaps
source ~/.config/nvim/keymaps.vim
