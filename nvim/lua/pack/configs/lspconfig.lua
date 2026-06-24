local ok_mason, mason = pcall(require, "mason")
if ok_mason then
  mason.setup()
end

local servers = {
  "lua_ls",
  "vtsls",
  "eslint",
  "html",
  "cssls",
  "tailwindcss",
  "jsonls",
  "jdtls",
  "basedpyright",
}

local ok_mason_lsp, mason_lsp = pcall(require, "mason-lspconfig")
if ok_mason_lsp then
  mason_lsp.setup({
    ensure_installed = servers,
    automatic_enable = false,
  })
end

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = {
    spacing = 2,
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.INFO] = "I",
      [vim.diagnostic.severity.HINT] = "H",
    },
  },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
})

for _, server in ipairs(servers) do
  if server ~= "jdtls" then
    pcall(vim.lsp.enable, server)
  end
end

local group = vim.api.nvim_create_augroup("user_lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    local bufnr = args.buf

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        noremap = true,
        silent = true,
        desc = desc,
      })
    end

    map("n", "gd", vim.lsp.buf.definition, "LSP definition")
    map("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
    map("n", "gr", vim.lsp.buf.references, "LSP references")
    map("n", "gi", vim.lsp.buf.implementation, "LSP implementation")
    map("n", "<leader>lh", vim.lsp.buf.hover, "LSP hover")
    map("n", "<leader>lr", vim.lsp.buf.rename, "LSP rename")
    map({ "n", "x" }, "<leader>la", vim.lsp.buf.code_action, "LSP code action")
    map("n", "<leader>ld", vim.diagnostic.open_float, "Line diagnostics")
    map("n", "<leader>lq", vim.diagnostic.setloclist, "Diagnostics loclist")
    map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
    map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")

    if vim.lsp.inlay_hint then
      map("n", "<leader>li", function()
        local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
      end, "Toggle inlay hints")
    end
  end,
  desc = "Set LSP buffer keymaps",
})
