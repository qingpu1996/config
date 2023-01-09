local status_ok, tabout = pcall(require, 'tabout')
if not status_ok then
  vim.notify('tabout not found!')
  return
end

tabout.setup {
  tabkey = '<Tab>',
  backwards_tabkey = '<S-Tab>',
  act_as_tab = true,
  act_as_shift_tab = false,
  enable_backwards = true,
  completion = false,
  tabouts = {
    {open = "'", close = "'"},
    {open = '"', close = '"'},
    {open = '`', close = '`'},
    {open = '(', close = ')'},
    {open = '{', close = '}'},
    {open = '[', close = ']'}
  },
  ignore_beginning = true,
  exclude = {}
}
