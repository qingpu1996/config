local group = vim.api.nvim_create_augroup("user_treesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end

    local name = vim.api.nvim_buf_get_name(args.buf)
    local ok, stats = pcall(vim.uv.fs_stat, name)
    if ok and stats and stats.size > 256 * 1024 then
      return
    end

    pcall(vim.treesitter.start, args.buf)
  end,
  desc = "Start built-in Treesitter when a parser is available",
})
