local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'rust_analyzer',
    'pyright',
})

lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

lsp.configure("rust_analyzer", {
    cmd = { "ra-multiplex" },
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs( -4),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp', keyword_length = 1 },
        { name = 'buffer',   keyword_length = 1 },
    }
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    set_lsp_keymaps = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
    vim.keymap.set("n", "gm", function() vim.lsp.buf.implementation() end)
    vim.keymap.set("i", "<C-j>", function() vim.lsp.buf.signature_help() end)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end)
    vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end)
    vim.keymap.set("n", "<leader>r", function() vim.lsp.buf.rename() end)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
    vim.keymap.set("n", "ga", function() vim.lsp.buf.code_action() end)
    vim.keymap.set("n", "go", function() vim.diagnostic.open_float() end)
    vim.keymap.set("n", "<C-n>", function() vim.diagnostic.goto_next() end)
    vim.keymap.set("n", "<C-p>", function() vim.diagnostic.goto_prev() end)
    vim.keymap.set("n", "gl", function() vim.diagnostic.setqflist() end)
    vim.keymap.set("i", "<Tab>", function() require("luasnip").jump(1) end)
    vim.keymap.set("i", "<S-Tab>", function() require("luasnip").jump( -1) end)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
