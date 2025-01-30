-- ~/.config/nvim/lua/terminal.lua

-- Setup toggleterm.nvim with your custom settings
require('toggleterm').setup({
  size = 20,                          -- Set terminal size (height in lines)
  open_mapping = [[<c-\>]],            -- Key mapping to toggle terminal
  hide_numbers = true,                 -- Hide line numbers in terminal
  shade_terminals = true,              -- Enable shading for terminals
  shading_factor = 2,                  -- Level of shading (0 to 100)
  direction = 'horizontal',           -- Set terminal direction: 'horizontal', 'vertical', or 'float'
  start_in_insert = true,              -- Open terminal in insert mode by default
  insert_mappings = true,              -- Enable terminal insert mappings (like vim keymaps)
  persist_mode = true,                 -- Keep terminal in the same mode when closing
  close_on_exit = true,                -- Close terminal automatically when process exits
  shell = vim.o.shell,                 -- Use the shell defined in Vim
  float_opts = {
    border = 'single',                 -- Set floating terminal border
    winblend = 3,                      -- Set floating window transparency
  },
})
