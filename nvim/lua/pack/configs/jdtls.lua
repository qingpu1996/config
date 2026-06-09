local ok, jdtls = pcall(require, "jdtls")
if not ok then
  return
end

local mason_registry = require("mason-registry")
local mason_path = vim.fn.stdpath("data") .. "/mason"

local function get_bundles()
  local bundles = {}

  if mason_registry.is_installed("java-debug-adapter") then
    local debug_path = mason_path .. "/packages/java-debug-adapter/extension/server"
    local debug_jars = vim.fn.glob(debug_path .. "/com.microsoft.java.debug.plugin-*.jar", true, true)
    vim.list_extend(bundles, debug_jars)
  end

  if mason_registry.is_installed("java-test") then
    local test_path = mason_path .. "/packages/java-test/extension/server"
    local test_jars = vim.fn.glob(test_path .. "/*.jar", true, true)
    vim.list_extend(bundles, test_jars)
  end

  return bundles
end

local function jdtls_on_attach(client, bufnr)
  jdtls.setup_dap({ hotcodereplace = "auto" })

  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
  end

  map("n", "<leader>lr", jdtls.organize_imports, "Organize imports")
  map("n", "<leader>iv", jdtls.extract_variable, "Extract variable")
  map("x", "<leader>iv", function() jdtls.extract_variable(true) end, "Extract variable")
  map("n", "<leader>ic", jdtls.extract_constant, "Extract constant")
  map("x", "<leader>ic", function() jdtls.extract_constant(true) end, "Extract constant")
  map("x", "<leader>im", function() jdtls.extract_method(true) end, "Extract method")
  map("n", "<leader>gt", jdtls.test_nearest_method, "Test nearest method")
  map("n", "<leader>gT", jdtls.test_class, "Test class")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" .. project_name

    local config = {
      cmd = {
        mason_path .. "/bin/jdtls",
        "-data", workspace_dir,
      },
      root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
      settings = {
        java = {
          signatureHelp = { enabled = true },
          completion = {
            favoriteStaticMembers = {
              "org.junit.Assert.*",
              "org.junit.jupiter.api.Assertions.*",
              "org.mockito.Mockito.*",
            },
          },
          sources = {
            organizeImports = {
              starThreshold = 9999,
              staticStarThreshold = 9999,
            },
          },
        },
      },
      init_options = {
        bundles = get_bundles(),
      },
      on_attach = jdtls_on_attach,
    }

    jdtls.start_or_attach(config)
  end,
  desc = "Start jdtls for Java files",
})
