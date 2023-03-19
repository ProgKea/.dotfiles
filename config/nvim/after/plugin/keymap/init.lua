-- Quickfixlist
vim.keymap.set("n", "<up>", "<cmd>cp<CR>")
vim.keymap.set("n", "<down>", "<cmd>cn<CR>")
vim.keymap.set("n", "qo", "<cmd>copen<CR>")

-- Dired or whatever you call it in vim
vim.keymap.set("n", "<leader>t", "<cmd>Ex<CR>")
vim.keymap.set("n", "<leader>T", "<cmd>Lexplore<CR>")

-- For more orientation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Save file shortcut
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
