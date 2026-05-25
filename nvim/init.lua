-- ========================================================================== --
-- SYSTEM SETTINGS & NEOCLASSIC VIM DEFAULTS                                  --
-- ========================================================================== --

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true          
vim.opt.relativenumber = true  
vim.opt.mouse = "a"            
vim.opt.clipboard = "unnamedplus" 
vim.opt.ignorecase = true      
vim.opt.smartcase = true       
vim.opt.undofile = true        
vim.opt.updatetime = 250       
vim.opt.timeoutlen = 300       
vim.opt.termguicolors = true   

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- ========================================================================== --
-- BOOTSTRAP LAZY.NVIM (Plugin Manager)                                       --
-- ========================================================================== --

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- ========================================================================== --
-- PLUGIN LIST                                                                --
-- ========================================================================== --

require("lazy").setup({
  -- Dark, terminal-friendly colorscheme
  { 
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function() vim.cmd("colorscheme kanagawa-dragon") end
  },

  -- Fast modular utilities (Statusline, Auto-pairs, File Explorer)
  { 
    'echasnovski/mini.nvim', 
    version = '*',
    config = function()
      require('mini.statusline').setup()
      require('mini.pairs').setup()
      require('mini.files').setup()
    end
  },

  -- Ultra-fast Fuzzy Finder
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Intelligent Syntax Highlighting
  { 
    'nvim-treesitter/nvim-treesitter', 
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.config').setup({
        ensure_installed = { "bash", "json", "lua", "toml", "markdown", "yaml" },
        highlight = { enable = true },
      })
    end
  },

  -- Automatically install and manage LSP servers / Tools
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      
      -- Let mason-lspconfig handle the automatic background installation for Lua
      require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls" }, -- Removed bashls (npm dependency)
        automatic_enable = false,
      })
    end
  },

  -- Blazingly Fast, Zero-Config Auto-completion Engine
  {
    'saghen/blink.cmp',
    version = '*',
    opts = {
      keymap = { preset = 'default' },
      sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
      fuzzy = { implementation = "lua" },
    },
  }
})

-- ========================================================================== --
-- AUTOMATED NATIVE LSP & LANGUAGE TOOLS LAUNCHER                            --
-- ========================================================================== --

local capabilities = require('blink.cmp').get_lsp_capabilities()
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/"

-- Native Bash Diagnostics via Shellcheck (No NPM / Node Required!)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'sh', 'bash' },
  callback = function()
    -- Automatically installs shellcheck via Mason if missing
    local registry = require('mason-registry')
    if registry.has_package('shellcheck') then
      local p = registry.get_package('shellcheck')
      if not p:is_installed() then 
        p:install() 
      end
    end
    
    -- Configures Neovim's compiler engine to use shellcheck for errors
    vim.cmd('compiler shellcheck')
    -- Automatically run lint check whenever you save the script
    vim.api.nvim_create_autocmd('BufWritePost', {
      buffer = vim.api.nvim_get_current_buf(),
      command = 'silent make | redraw!',
    })
  end,
})

-- Native Lua Configuration (Points to Mason's local installation directory)
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.lsp.start({
      name = 'lua-language-server',
      cmd = { mason_bin .. 'lua-language-server' },
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME },
          },
        },
      },
    })
  end,
})

-- ========================================================================== --
-- KEYMAPS & SHORTCUTS                                                        --
-- ========================================================================== --

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep,  { desc = 'Live Grep (Search Text)' })
vim.keymap.set('n', '<leader>fb', builtin.buffers,    { desc = 'Find Open Buffers' })

vim.keymap.set('n', '<leader>e', function() MiniFiles.open() end, { desc = 'Open File Explorer' })

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous issue' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next issue' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show floating error message' })

vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save File' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit Neovim' })
