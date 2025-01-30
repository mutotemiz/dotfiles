local lspconfig = require('lspconfig')

-- Setup Pyright with custom settings
lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",  -- Set to "strict" or "off" if needed
      },
    },
  },
})
