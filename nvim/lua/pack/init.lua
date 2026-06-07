local specs = require("pack.specs")

local function plugin_names(arg_lead)
  local plugins = vim.pack.get(nil, { info = false })
  local names = {}

  for _, plugin in ipairs(plugins) do
    local name = plugin.spec.name
    if name:lower():find(arg_lead:lower(), 1, true) == 1 then
      table.insert(names, name)
    end
  end

  table.sort(names)
  return names
end

vim.api.nvim_create_user_command("PackUpdate", function(opts)
  local names = #opts.fargs > 0 and opts.fargs or nil
  vim.pack.update(names, { force = opts.bang })
end, {
  nargs = "*",
  bang = true,
  complete = plugin_names,
  desc = "Update plugins managed by vim.pack",
})

vim.api.nvim_create_user_command("PackStatus", function(opts)
  local names = #opts.fargs > 0 and opts.fargs or nil
  vim.pack.update(names, { offline = true })
end, {
  nargs = "*",
  complete = plugin_names,
  desc = "Show vim.pack plugin status without downloading",
})

vim.pack.add(specs, { confirm = false, load = true })

for _, name in ipairs({
  "lspconfig",
  "blink",
  "conform",
  "gitsigns",
  "which-key",
  "fzf",
  "lazygit",
  "yazi",
  "mini",
  "outline",
  "undotree",
}) do
  local ok, err = pcall(require, "pack.configs." .. name)
  if not ok then
    vim.schedule(function()
      vim.notify(("Failed to load pack.configs.%s: %s"):format(name, err), vim.log.levels.ERROR)
    end)
  end
end
