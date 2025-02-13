-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('nvim-tree').setup {
        renderer = {
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
            glyphs = {
              default = '',
              symlink = '',
              git = {
                unstaged = '✗',
                staged = '✓',
                unmerged = '',
                renamed = '➜',
                untracked = '★',
                deleted = '',
                ignored = '◌',
              },
              folder = {
                arrow_open = '',
                arrow_closed = '',
                default = '',
                open = '',
                empty = '',
                empty_open = '',
                symlink = '',
                symlink_open = '',
              },
            },
          },
        },
        view = {
          width = 30,
          side = 'left',
          -- mappings = {
          --  list = {
          --    { key = { 'l', '<CR>', 'o' }, cb = tree_cb 'edit' },
          --    { key = 'h', cb = tree_cb 'close_node' },
          --    { key = 'v', cb = tree_cb 'vsplit' },
          --  },
          -- },
        },
      }
      -- Nvim-Tree Toggle Keybinding
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle NvimTree' })

      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          require('nvim-tree.api').tree.open() -- Open the tree when Neovim starts
        end,
      })
    end,
  },

  -- Toggle Term
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      require('toggleterm').setup {
        size = 10, -- Size of the terminal window
        open_mapping = [[<c-\>]], -- Keybinding to toggle the terminal
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = 'horizontal', -- You can change this to 'vertical' or 'float'
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = 'curved',
          winblend = 3,
        },
      }

      -- Keybinding to toggle terminal
      vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm<CR>', { desc = 'Toggle Terminal' })
    end,
  },

  -- Tabbed Buffers
  {
    'akinsho/bufferline.nvim',
    version = '*',
    requires = 'nvim-tree/nvim-web-devicons', -- Optional, for file icons
    config = function()
      require('bufferline').setup {
        options = {
          numbers = 'both', -- Display both buffer number and ordinal
          diagnostics = 'nvim_lsp',
          separator_style = 'slant', -- Use slanted separators
          offsets = {
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              text_align = 'left',
              separator = true,
            },
          },
        },
      }
      -- Keybinding for Control + Tab to change buffer focus
      vim.keymap.set('n', '<C-Tab>', '<cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer' })
      vim.keymap.set('n', '<C-S-Tab>', '<cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer' })
    end,
  },

  -- debugpy
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap-python',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      local dap_python = require 'dap-python'

      require('dapui').setup {}
      require('nvim-dap-virtual-text').setup {
        commented = true, -- Show virtual text alongside comment
      }

      dap_python.setup 'python3'

      vim.fn.sign_define('DapBreakpoint', {
        text = '',
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      })

      vim.fn.sign_define('DapBreakpointRejected', {
        text = '', -- or "❌"
        texthl = 'DiagnosticSignError',
        linehl = '',
        numhl = '',
      })

      vim.fn.sign_define('DapStopped', {
        text = '', -- or "→"
        texthl = 'DiagnosticSignWarn',
        linehl = 'Visual',
        numhl = 'DiagnosticSignWarn',
      })

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      local opts = { noremap = true, silent = true }

      local function extend_opts(desc)
        local new_opts = vim.tbl_extend('force', opts, { desc = desc })
        return new_opts
      end

      -- Toggle breakpoint
      vim.keymap.set('n', '<leader>db', function()
        dap.toggle_breakpoint()
      end, extend_opts 'Toggle [b]reakpoint')

      -- Continue / Start
      vim.keymap.set('n', '<leader>dc', function()
        dap.continue()
      end, extend_opts '[c]ontinue / start')

      -- Step Over
      vim.keymap.set('n', '<leader>do', function()
        dap.step_over()
      end, extend_opts 'Step [o]ver')

      -- Step Into
      vim.keymap.set('n', '<leader>di', function()
        dap.step_into()
      end, extend_opts 'Step [i]nto')

      -- Step Out
      vim.keymap.set('n', '<leader>dO', function()
        dap.step_out()
      end, extend_opts 'Step [O]ut')

      -- Keymap to terminate debugging
      vim.keymap.set('n', '<leader>dq', function()
        require('dap').terminate()
      end, extend_opts '[q]uit')

      -- Toggle DAP UI
      vim.keymap.set('n', '<leader>du', function()
        dapui.toggle()
      end, extend_opts 'Toggle DAP [u]I')
    end,
  },
}
