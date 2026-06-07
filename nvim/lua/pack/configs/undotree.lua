local ok, undotree = pcall(require, "undotree")
if not ok then
  return
end

undotree.setup({})

vim.keymap.set("n", "<leader>u", function()
  undotree.toggle()
end, { noremap = true, silent = true, desc = "Toggle undo tree" })
