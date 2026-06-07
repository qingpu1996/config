local ok, blink = pcall(require, "blink.cmp")
if not ok then
  return
end

blink.setup({
  keymap = {
    preset = "default",
    ["<CR>"] = { "accept", "fallback" },
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
    },
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
})
