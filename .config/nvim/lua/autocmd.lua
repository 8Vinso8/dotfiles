vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    -- Try to start treesitter highlighting if a parser exists for this filetype
    pcall(vim.treesitter.start, args.buf)
  end,
})
