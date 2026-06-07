local map = vim.keymap.set

local function opts(desc)
  return { noremap = true, silent = true, desc = desc }
end

map({ "n", "x" }, "Q", "<cmd>quit<cr>", opts("Quit"))
map({ "n", "x" }, "S", "<cmd>write<cr>", opts("Save"))
map("n", "<leader><cr>", "<cmd>nohlsearch<cr>", opts("Clear search highlight"))
map("n", "U", "<C-r>", opts("Redo"))

map("n", "<leader>w", "<C-w>w", opts("Next window"))
map("n", "<leader>i", "<C-w>k", opts("Window up"))
map("n", "<leader>n", "<C-w>j", opts("Window down"))
map("n", "<leader>y", "<C-w>h", opts("Window left"))
map("n", "<leader>o", "<C-w>l", opts("Window right"))

map("n", "<S-Tab>", "<cmd>bnext<cr>", opts("Next buffer"))
map("n", "<C-t>", "<cmd>tab split<cr>", opts("Open current buffer in new tab"))
map("n", "X", "<cmd>bdelete<cr>", opts("Delete buffer"))
