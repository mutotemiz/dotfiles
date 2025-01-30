-- ~/.config/nvim/lua/nvimtree.lua
local M = {}

M.setup = function()
  require('nvim-tree').setup {
    -- Your nvim-tree configuration here
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    update_cwd = true,
    view = {
      width = auto,
      side = 'left',
      -- auto_resize = true,
    },
    git = {
      enable = true,
      ignore = false,
    },
    renderer = {
      highlight_opened_files = 'name',
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
	glyphs = {
          default = '',  -- Default file icon (you can customize these)
          symlink = '',  -- Symbolic link icon
          git = {
            unstaged = '✗',  -- Unstaged file icon
            staged = '✓',    -- Staged file icon
            untracked = '★', -- Untracked file icon
            ignored = '◌',   -- Ignored file icon
        },
       },
      },
    },
  }
end

return M
