local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    git = {
        clone_timeout = 300, -- Timeout, in seconds, for git clones
    },
})

-- Install your plugins here
return packer.startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- display keybindings
    use("folke/which-key.nvim")

    -- colorschemes
    use("lunarvim/darkplus.nvim")

    -- indentation guides
    use("lukas-reineke/indent-blankline.nvim")

    -- escape insert mode quickly (default jk)
    use("jdhao/better-escape.vim")

    -- statusline
    use("nvim-lualine/lualine.nvim")

    -- file explorer
    use("nvim-tree/nvim-web-devicons")
    use("nvim-tree/nvim-tree.lua")
    use("qpkorr/vim-bufkill")

    -- snippets
    use("L3MON4D3/LuaSnip")
    use("rafamadriz/friendly-snippets")

    -- telescope
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")

    -- terminal
    use("vimlab/split-term.vim")
    use("akinsho/toggleterm.nvim")

    -- git
    use("lewis6991/gitsigns.nvim")

    -- bufferline
    use("akinsho/bufferline.nvim")

    -- autopairs
    use("windwp/nvim-autopairs")

    -- comments
    use("numToStr/Comment.nvim")
    use("JoosepAlviste/nvim-ts-context-commentstring")

    -- LaTeX
    use("lervag/vimtex")

    -- completion
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-nvim-lua")
    use("saadparwaiz1/cmp_luasnip")

    -- language server
    use("nvimtools/none-ls.nvim")
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    -- syntax highlighting
    use("nvim-treesitter/nvim-treesitter")

    -- Github copilot
    use("github/copilot.vim")

    -- misc
    use("natecraddock/sessions.nvim")
    use("tpope/vim-repeat")
    use("tpope/vim-surround")

    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
