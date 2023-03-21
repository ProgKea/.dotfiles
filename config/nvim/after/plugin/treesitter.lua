require("nvim-treesitter.configs").setup {
    ensure_installed = "all",
    ignore_install = { "markdown_inline" },
    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    indent = {
        enable = true,
        -- disable = { "python" }
    },

    autotag = {
        enable = true
    }
}
