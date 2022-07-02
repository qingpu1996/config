local status_ok, auto_pairs = pcall(require, 'nvim-autopairs')
if not status_ok then
  vim.notify('autopairs not found!')
  return
end

auto_pairs.setup {
  check_ts = true,
  ts_config = {
    lua = { 'string', 'source' },
    javascript = { 'string', 'template_string' },
    java = false
  },
  disable_filetype = { 'TelescopePromt', 'spectre_panel', 'dap-repl', 'guihua', 'guihua_rust', 'clap_input' },
  fast_wrap = {
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0,
    end_key = '$',
    keys = 'qwdfkjurlasetgyniohzxcvbpm',
    check_comma = true
  }
}
