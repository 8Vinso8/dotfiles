local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  end,
})

-- Use Tab to cycle forward in completion menu, Shift-Tab to cycle backward
vim.keymap.set("i", "<Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true })

-- Confirm selection with Enter
vim.keymap.set("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 then
    -- Check if a menu item is actually selected (complete_info().selected ~= -1)
    if vim.fn.complete_info({ "selected" }).selected ~= -1 then
      return "<C-y>"     -- Accept completion
    else
      return "<C-e><CR>" -- Close completion menu, then insert newline
    end
  end
  return "<CR>"
end, { expr = true, replace_keycodes = true })

vim.keymap.set("i", "<Down>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-e><Down>" -- Close menu, move cursor down
  end
  return "<Down>"
end, { expr = true, replace_keycodes = true })

vim.keymap.set("i", "<Up>", function()
  if vim.fn.pumvisible() == 1 then
    return "<C-e><Up>" -- Close menu, move cursor up
  end
  return "<Up>"
end, { expr = true, replace_keycodes = true })

vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
