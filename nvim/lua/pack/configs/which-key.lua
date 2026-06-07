local ok, which_key = pcall(require, "which-key")
if not ok then
  return
end

which_key.setup({})

if which_key.add then
  which_key.add({
    { "<leader>h", group = "git hunk" },
    { "<leader>l", group = "lsp" },
  })
end
