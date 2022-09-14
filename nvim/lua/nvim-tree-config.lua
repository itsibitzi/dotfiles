vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup {
    git = {
        enable = true,
        ignore = false,
        timeout = 400,
    },
}
