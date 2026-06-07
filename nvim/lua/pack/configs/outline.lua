local ok, outline = pcall(require, "outline")
if not ok then
  return
end

outline.setup({
  outline_window = {
    position = "left",
    width = 28,
  },
})

vim.keymap.set("n", "<leader>lo", "<cmd>Outline<cr>", {
  noremap = true,
  silent = true,
  desc = "Toggle outline",
})
