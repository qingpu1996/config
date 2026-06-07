local ok, fzf = pcall(require, "fzf-lua")
if not ok then
  return
end

fzf.setup({
  winopts = {
    height = 0.85,
    width = 0.9,
    preview = {
      layout = "flex",
    },
  },
  fzf_opts = {
    ["--layout"] = "reverse",
  },
})

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>se", fzf.files, vim.tbl_extend("force", opts, { desc = "Find files" }))
map("n", "<leader>sg", fzf.live_grep, vim.tbl_extend("force", opts, { desc = "Grep files" }))
map("n", "<leader>fw", fzf.grep_cword, vim.tbl_extend("force", opts, { desc = "Grep word" }))
map("n", "<leader>fb", fzf.buffers, vim.tbl_extend("force", opts, { desc = "Find buffers" }))
map("n", "<leader>fr", fzf.oldfiles, vim.tbl_extend("force", opts, { desc = "Recent files" }))
map("n", "<leader>fh", fzf.helptags, vim.tbl_extend("force", opts, { desc = "Find help" }))
map("n", "<leader>fl", fzf.blines, vim.tbl_extend("force", opts, { desc = "Buffer lines" }))
map("n", "<leader>fs", fzf.lsp_document_symbols, vim.tbl_extend("force", opts, { desc = "LSP symbols" }))
map("n", "<leader>fS", fzf.lsp_workspace_symbols, vim.tbl_extend("force", opts, { desc = "Workspace symbols" }))
map("n", "<leader>fd", fzf.diagnostics_document, vim.tbl_extend("force", opts, { desc = "Document diagnostics" }))
map("n", "<leader>fD", fzf.diagnostics_workspace, vim.tbl_extend("force", opts, { desc = "Workspace diagnostics" }))
