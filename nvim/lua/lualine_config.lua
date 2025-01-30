-- ~/.config/nvim/lua/lualine_config.lua
local M = {}

M.setup = function()
  require('lualine').setup {
    options = {
      theme = 'gruvbox',  -- Choose a theme for your status line
      section_separators = {'', ''},  -- Custom separators between sections
      component_separators = {'', ''},  -- Custom separators between components
    },
    sections = {
      lualine_a = {'mode'},  -- Show current mode (Normal, Insert, etc.)
      lualine_b = {'branch'},  -- Show git branch
      lualine_c = {'filename'},  -- Show the current file name
      lualine_x = {'encoding', 'fileformat', 'filetype'},  -- Encoding, file format, and file type
      lualine_y = {'progress'},  -- Show file progress as a percentage
      lualine_z = {'location'},  -- Show line and column number
    },
    extensions = {'fugitive', 'nvim-tree'},  -- Optional: Enable fugitive (Git) and nvim-tree extensions
  }
end

return M

