
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({

    change_detection = {
        notify = false
    },

    -- styling
    'nvim-lualine/lualine.nvim',
    'petertriho/nvim-scrollbar',
    'folke/zen-mode.nvim',
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    { "lukas-reineke/virt-column.nvim", opts = {} },
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        lazy = false,
        build = ':TSUpdate'
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    },

    -- colorschemes
    'rebelot/kanagawa.nvim',
    'projekt0n/github-nvim-theme',
    'sainnhe/gruvbox-material',
    'sainnhe/everforest',
    'sainnhe/sonokai',
    'AlexvZyl/nordic.nvim',
    { 
        "ellisonleao/gruvbox.nvim", 
        priority = 1000 , 
        config = true, 
        opts = ...
    },

    -- misc
    'sharkdp/fd',
    'schickling/vim-bufonly',
    'stevearc/aerial.nvim',
    'mfussenegger/nvim-dap',
    'meznaric/key-analyzer.nvim',
    {
        'lervag/vimtex',
        lazy = false,
        init = function()
            vim.g.tex_flavor='latex'
            vim.g.vimtex_view_method='zathura'
            vim.g.vimtex_quickfix_mode=0
            vim.g.tex_conceal='abdmg'
        end
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = 'master',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        lazy = false,
        priority = 1000,
        config = function()
            require('github-theme').setup({
            -- ...
            })
            vim.cmd('colorscheme github_dark')
        end,
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = require("plugin_configs.snacks"),
    }
})

