vim.keymap.set("n", "<leader>g", function()
  if vim.fn.executable("lazygit") == 0 then
    vim.notify("lazygit is not available on PATH", vim.log.levels.ERROR)
    return
  end

  vim.cmd("tabnew")
  vim.cmd("terminal lazygit")
  vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Lazygit" })
