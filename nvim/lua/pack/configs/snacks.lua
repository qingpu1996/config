local ok, snacks = pcall(require, "snacks")
if not ok then
  return
end

snacks.setup({
  lazygit = {},
  notifier = {},
  picker = {
    win = {
      input = {
        keys = {
          ["<Esc>"] = { "close", mode = { "n", "i" } },
        },
      },
    },
  },
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>ff", function()
  Snacks.picker.files()
end, vim.tbl_extend("force", opts, { desc = "Find files" }))

map("n", "<leader>fg", function()
  Snacks.picker.grep()
end, vim.tbl_extend("force", opts, { desc = "Grep files" }))

map("n", "<leader>fw", function()
  Snacks.picker.grep_word()
end, vim.tbl_extend("force", opts, { desc = "Grep word" }))

map("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, vim.tbl_extend("force", opts, { desc = "Find buffers" }))

map("n", "<leader>fr", function()
  Snacks.picker.recent()
end, vim.tbl_extend("force", opts, { desc = "Recent files" }))

map("n", "<leader>fh", function()
  Snacks.picker.help()
end, vim.tbl_extend("force", opts, { desc = "Find help" }))

map("n", "<leader>fl", function()
  Snacks.picker.lines()
end, vim.tbl_extend("force", opts, { desc = "Buffer lines" }))

map("n", "<leader>fs", function()
  Snacks.picker.lsp_symbols()
end, vim.tbl_extend("force", opts, { desc = "LSP symbols" }))

map("n", "<leader>fS", function()
  Snacks.picker.lsp_workspace_symbols()
end, vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))

map("n", "<leader>g", function()
  Snacks.lazygit()
end, vim.tbl_extend("force", opts, { desc = "Lazygit" }))
