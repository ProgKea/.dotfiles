local augroup = vim.api.nvim_create_augroup
NeovimGroup = augroup('KikuNvim', {})

require("kikunvim.set")
require("kikunvim.packer")
require("kikunvim.theme")

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Remove autocomments on newlines
autocmd('BufEnter', {
    pattern = '*',
    callback = function()
        vim.opt.formatoptions:remove { "c", "r", "o" }
        -- vim.cmd("clearjumps")
    end,
})
