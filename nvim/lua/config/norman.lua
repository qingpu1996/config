local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local mappings = {
  d = "e",
  f = "r",
  k = "t",
  j = "y",
  r = "i",
  l = "o",
  h = "p",
  e = "d",
  t = "f",
  y = "h",
  n = "j",
  i = "k",
  o = "l",
  p = "n",
  D = "E",
  F = "R",
  K = "T",
  J = "Y",
  R = "I",
  L = "O",
  H = "P",
  E = "D",
  T = "F",
  Y = "^",
  N = "5j",
  I = "5k",
  O = "$",
  P = "N",
}

for lhs, rhs in pairs(mappings) do
  map({ "n", "x", "o" }, lhs, rhs, opts)
end
