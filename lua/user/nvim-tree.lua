-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with some options
require("nvim-tree").setup({
    disable_netrw = true,
    git = {
        timeout = 1000,
    },
    sort = {
        sorter = "case_sensitive",
    },
    actions = {
        change_dir = {
            enable = true,
            restrict_above_cwd = true,
        },
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})
