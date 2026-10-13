local ts = require("nvim-treesitter")
ts.install({ "lua", "bash", "json", "toml", "yaml", "vim", "markdown" })

vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 4,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
})

vim.o.complete = ".,w,b,o"
vim.o.completeopt = "menuone,noselect,fuzzy"
vim.o.autocomplete = true
vim.o.autocompletedelay = 250

vim.lsp.enable("lua_ls")
