vim.g.lazygit_floating_window_winblend = 0
vim.g.lazygit_floating_window_scaling_factor = 0.95
vim.g.lazygit_floating_window_use_plenary = 1
vim.g.lazygit_use_neovim_remote = 1

vim.keymap.set("n", "<leader>lg", function()
  if vim.fn.executable("lazygit") == 0 then
    vim.notify("lazygit is not available on PATH", vim.log.levels.ERROR)
    return
  end

  vim.cmd("LazyGit")
end, { noremap = true, silent = true, desc = "Lazygit" })
