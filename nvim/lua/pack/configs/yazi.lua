local ok, yazi = pcall(require, "yazi")
if not ok then
  return
end

yazi.setup({
  open_for_directories = true,
  keymaps = {
    show_help = "<f1>",
    replace_in_directory = false,
    open_and_pick_window = false,
  },
  integrations = {
    grep_in_directory = "fzf-lua",
    grep_in_selected_files = "fzf-lua",
  },
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map({ "n", "v" }, "<leader>e", "<cmd>Yazi<cr>", vim.tbl_extend("force", opts, { desc = "Yazi" }))
map("n", "<leader>E", "<cmd>Yazi cwd<cr>", vim.tbl_extend("force", opts, { desc = "Yazi cwd" }))
