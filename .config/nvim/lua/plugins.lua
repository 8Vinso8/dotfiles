vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },

  "https://github.com/echasnovski/mini.icons",

  "https://github.com/stevearc/oil.nvim",

  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope.nvim",

  "https://github.com/nvim-lualine/lualine.nvim",

  "https://github.com/folke/lazydev.nvim",

  "https://github.com/neovim/nvim-lspconfig",

  "https://github.com/windwp/nvim-autopairs",

  "https://github.com/nvim-treesitter/nvim-treesitter"
})

require("catppuccin").setup({ flavour = "mocha", })
vim.cmd.colorscheme "catppuccin-nvim"

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})

require("lualine").setup({
  options = {
    globalstatus = true,
  },
})

require("lazydev").setup()

require("nvim-autopairs").setup({
  check_ts = true,
})
