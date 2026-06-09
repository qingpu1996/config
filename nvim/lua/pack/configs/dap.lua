local ok_dap, dap = pcall(require, "dap")
if not ok_dap then
  return
end

local ok_dapui, dapui = pcall(require, "dapui")
if ok_dapui then
  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

local function map(lhs, rhs, desc)
  vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true, desc = desc })
end

map("<leader>bb", dap.toggle_breakpoint, "Toggle breakpoint")
map("<leader>dd", dap.continue, "Debug continue")
map("<leader>ds", dap.step_over, "Step over")
map("<leader>di", dap.step_into, "Step into")
map("<leader>do", dap.step_out, "Step out")

if ok_dapui then
  map("<leader>du", dapui.toggle, "Toggle DAP UI")
end
