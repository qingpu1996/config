local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
  vim.notify('bufferline not found!')
  return
end

bufferline.setup {
  options = {
    mode = 'buffers',
    numbers = 'ordinal',
    close_command = 'bdelete! %d',
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    name_formatter = function(buf)
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_default_icon = true,
    show_close_icon = true
  }
}
