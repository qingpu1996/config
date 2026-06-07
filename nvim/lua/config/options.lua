vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.wildmenu = true
opt.inccommand = "split"

opt.mouse = "a"
opt.scrolloff = 3
opt.sidescrolloff = 8
opt.wrap = false
opt.list = true
opt.listchars = {
  tab = "> ",
  trail = ".",
  extends = ">",
  precedes = "<",
  nbsp = "+",
}

opt.swapfile = false
opt.undofile = true
opt.updatetime = 300
opt.timeoutlen = 500
opt.foldlevel = 99
opt.clipboard = "unnamedplus"
opt.splitright = true
opt.splitbelow = true

opt.shortmess:append("c")
opt.whichwrap:append("<,>,[,],h,l")
