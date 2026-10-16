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

  "https://github.com/nvim-treesitter/nvim-treesitter",

  "https://github.com/folke/which-key.nvim",

  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("*"),
  },
})

require("catppuccin").setup({
  flavour = "mocha",
  integrations = {
    treesitter = true,
    telescope = true,
    mini = true,
    which_key = true,
    blink_cmp = true,
  },
})
vim.cmd.colorscheme "catppuccin-nvim"

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})

require("telescope").setup({
  defaults = {
    file_ignore_patterns = { "%.git/", "node_modules/" },
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
})

require("lualine").setup({
  options = {
    theme = "catppuccin-nvim",
    globalstatus = true,
  },
})

require("lazydev").setup()

require("nvim-autopairs").setup({
  check_ts = true,
})

require("which-key").setup({
  preset = "modern",
})

require("blink.cmp").setup({
  keymap = { preset = "super-tab" },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = "rounded" },
    },
    menu = {
      border = "rounded",
    },
  },
  signature = {
    enabled = true,
    window = { border = "rounded" },
  },
})
