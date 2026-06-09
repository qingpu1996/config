local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
  return
end

catppuccin.setup({
  flavour = "mocha",
  background = {
    light = "latte",
    dark = "mocha",
  },
  term_colors = true,
  transparent_background = false,
  default_integrations = true,
  integrations = {
    blink_cmp = {
      style = "bordered",
    },
    dap = true,
    dap_ui = true,
    fzf = true,
    gitsigns = true,
    mason = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
    native_lsp = {
      enabled = true,
    },
    treesitter = true,
    which_key = true,
  },
})

vim.cmd.colorscheme("catppuccin-mocha")
