--NvimTree Keybindings
vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Toggle horizontal terminal with <leader>t
vim.api.nvim_set_keymap('n', '<leader>t', ':ToggleTerm direction=horizontal<CR>', { noremap = true, silent = true })
