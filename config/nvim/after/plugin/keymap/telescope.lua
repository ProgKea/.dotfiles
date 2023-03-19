-- TODO: maybe prefix telescope with C-t and put not so important stuff under the prefix

vim.keymap.set("n", "<C-f>", "<cmd>lua require('telescope.builtin').find_files()<CR>")
vim.keymap.set("n", "<C-t>g", "<cmd>lua require('telescope.builtin').git_files()<CR>")
vim.keymap.set("n", "<C-t>b", "<cmd>lua require('telescope.builtin').buffers()<CR>")
vim.keymap.set("n", "<C-t>r", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
