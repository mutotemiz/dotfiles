-- ~/.config/nvim/lua/plugins.lua
return {
  -- nvim-web-devicons for file icons
  {
    'nvim-tree/nvim-web-devicons',  -- Icons dependency for nvim-tree
  },

  -- 'nvim-tree' plugin
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvimtree').setup() 
    end,
  },

  -- lualine for the status line
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine_config').setup()
    end,
  },

  -- toggleterm
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('terminal')  -- Load the terminal configuration from a separate terminal.lua file
    end,
  },
  
  -- Other plugins go here
  -- {
  --   'some/other-plugin',
  --   config = function()
  --     -- plugin-specific configuration
  --   end,
  -- },
}

