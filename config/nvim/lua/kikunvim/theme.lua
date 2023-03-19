vim.opt.background = "dark"

require("gruvbox").setup({
    contrast = "hard",
})

vim.cmd("colorscheme gruvbox")

local hl = function(thing, opts)
    vim.api.nvim_set_hl(0, thing, opts)
end

-- hl("ColorColumn", {
--     ctermbg = 0,
--     bg = "#555555",
-- })
--
-- hl("LineNr", {
--     fg = "#5eacd3"
-- })
--
-- hl("netrwDir", {
--     fg = "#5eacd3"
-- })

hl("Normal", {
    bg = "None"
})

hl("SignColumn", {
    bg = "None",
})

hl("CursorLineNR", {
    bg = "None"
})

hl("TelescopeNormal", {
    bg = "None"
})

hl("TelescopeBorder", {
    bg = "None"
})

hl("TelescopeTitle", {
    bg = "None"
})
