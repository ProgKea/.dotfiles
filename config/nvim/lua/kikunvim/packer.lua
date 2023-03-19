-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("ThePrimeagen/harpoon")
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use("nvim-telescope/telescope-fzy-native.nvim")
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use("windwp/nvim-autopairs")

    -- I am not willing to trade performance for pretty code
    -- use("windwp/nvim-ts-autotag")
    -- use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    -- use("nvim-treesitter/nvim-treesitter-context")

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            { 'neovim/nvim-lspconfig' },
            -- { 'williamboman/mason.nvim' },
            -- { 'williamboman/mason-lspconfig.nvim' },
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use("ellisonleao/gruvbox.nvim")
end)
