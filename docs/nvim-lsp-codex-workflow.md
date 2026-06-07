# Neovim LSP Codex 工作流

调研时间：2026-06-08

## 结论

现在这套配置下一步最稳的方向是：

- 插件管理：第一方 `vim.pack`。
- LSP：Neovim 0.11+ 原生 `vim.lsp.config()` / `vim.lsp.enable()`，配合 `nvim-lspconfig` 提供 server configs。
- 外部工具安装：`mason.nvim` 管 LSP server、DAP server、linter、formatter。
- 补全：优先看 `blink.cmp`，备选是老牌 `nvim-cmp`。
- 格式化：`conform.nvim`。
- lint：`nvim-lint`。
- fuzzy finder：`fzf-lua`。
- 文件管理：`yazi` + `yazi.nvim`，替代传统目录树。
- Git buffer 集成：`gitsigns.nvim`。
- 辅助 UI：`which-key.nvim`、`trouble.nvim`。
- Codex：目前没有看到 OpenAI 官方的一方 Neovim 插件。建议先用 Codex CLI 作为终端 agent，通过 `$EDITOR=nvim`、`AGENTS.md`、MCP、终端 pane 和后续简单 Neovim command 连接。

## 包管理器

### vim.pack 是这套配置的主选择

这套配置现在按第一方优先原则采用 `vim.pack`。Neovim 官方文档已经提供 `vim.pack.add()`、`vim.pack.update()`、`vim.pack.del()`、lockfile、`:packupdate` 等能力；`nvim-lspconfig` README 也直接给了 Nvim 0.12+ 用 `vim.pack.add()` 安装的例子。

来源：

- https://neovim.io/doc/user/pack/

### lazy.nvim 是社区常见选择，但本配置暂不采用

`lazy.nvim` 仍然是社区里非常常见的插件管理器。它的优势不是只有“能装插件”，而是插件懒加载、依赖顺序、lockfile、更新检查、profile、UI 都成熟。它的 README 明确定位为现代 Neovim plugin manager，并列出自动 lazy-load、依赖排序、`lazy-lock.json` 等能力。

当前不采用它的原因是：你倾向第一方工具，而 `vim.pack` 已经能覆盖当前阶段需要的插件安装、更新和 lockfile。

来源：

- https://github.com/folke/lazy.nvim

### 不建议继续用 packer.nvim

旧配置里曾经用过 `packer.nvim`。这个方向不建议继续投入，因为 `packer.nvim` 仓库已经在 README 里写明当前不维护，并推荐改用 `lazy.nvim` 或 `pckr.nvim`。

来源：

- https://github.com/wbthomason/packer.nvim

## LSP 配置方向

Neovim 0.11+ 后，LSP 配置方式已经变了。`nvim-lspconfig` README 里明确写到：`require('lspconfig')` 这个旧 framework 已经 deprecated，推荐使用 `vim.lsp.config()` 和 `vim.lsp.enable()`；但 `nvim-lspconfig` 本身没有 deprecated，它仍然提供 server-specific configs。

这意味着后续配置应该避免写成：

```lua
require("lspconfig").pyright.setup({})
```

而是倾向于：

```lua
vim.lsp.config("pyright", {
  -- override settings here
})
vim.lsp.enable("pyright")
```

来源：

- https://github.com/neovim/nvim-lspconfig
- https://neovim.io/doc/user/lsp.html

## 基础插件分层

第一阶段只加真正支撑开发体验的插件：

| 层级 | 插件 | 用途 |
| --- | --- | --- |
| 插件管理 | `vim.pack` | 第一方插件安装、更新、lockfile |
| 外部工具 | `mason-org/mason.nvim` | 安装 LSP/DAP/linter/formatter |
| LSP configs | `neovim/nvim-lspconfig` | 提供社区 server config |
| completion | `Saghen/blink.cmp` | LSP、cmdline、snippet、buffer 等补全 |
| formatting | `stevearc/conform.nvim` | format on save、formatter 编排 |
| linting | `mfussenegger/nvim-lint` | 独立 linter 输出到 `vim.diagnostic` |
| picker | `ibhagwan/fzf-lua` | 文件、grep、buffer、recent、help、LSP symbol/action |
| file manager | `mikavilpas/yazi.nvim` + `yazi` | 浮动终端文件管理、目录 buffer 接管、和 fzf-lua grep 集成 |
| Git signs | `lewis6991/gitsigns.nvim` | buffer 内显示/stage/reset hunk |
| key hint | `folke/which-key.nvim` | 快捷键提示，适合 Norman 映射梳理 |
| diagnostics list | `folke/trouble.nvim` | diagnostics、references、quickfix、picker 结果列表 |

来源：

- https://github.com/mason-org/mason.nvim
- https://github.com/Saghen/blink.cmp
- https://github.com/stevearc/conform.nvim
- https://github.com/mfussenegger/nvim-lint
- https://github.com/ibhagwan/fzf-lua
- https://github.com/mikavilpas/yazi.nvim
- https://github.com/sxyazi/yazi
- https://github.com/lewis6991/gitsigns.nvim
- https://github.com/folke/which-key.nvim
- https://github.com/folke/trouble.nvim

## 前端开发建议

前端栈不要先追求“像 VS Code 一样什么都有”，先把最常用路径配稳：

### LSP servers

| 语言/场景 | 建议 |
| --- | --- |
| TypeScript / JavaScript | 优先评估 `vtsls` 或 `typescript-language-server` |
| ESLint | `eslint` language server 或独立 lint |
| HTML | `html` |
| CSS | `cssls` |
| Tailwind | `tailwindcss` |
| JSON | `jsonls` |
| Vue/Svelte/Astro | 需要时再加对应 server |

TypeScript 有两条路线：

- `vtsls`：更接近 VS Code TypeScript extension 的 LSP wrapper，功能较强，但作者也提示它是 best-effort，不保证绝对稳。
- `typescript-language-server`：更通用、更传统，项目目标是给非 VS Code 编辑器提供 TypeScript/JavaScript 的 LSP 接口。

建议先从 `vtsls` 开始试。如果大型项目或某些行为不稳定，再降到 `typescript-language-server` 或 `typescript-tools.nvim`。

来源：

- https://github.com/yioneko/vtsls
- https://github.com/typescript-language-server/typescript-language-server
- https://github.com/pmizio/typescript-tools.nvim
- https://github.com/tailwindlabs/tailwindcss-intellisense

### Formatter / linter

推荐：

- JavaScript/TypeScript/JSON/CSS/HTML：`prettier` 或 `prettierd`，由 `conform.nvim` 调用。
- ESLint：项目本身如果已经配置 ESLint，就用 ESLint 做 lint 和部分 fix。
- 不建议让 LSP formatting、Prettier、ESLint fix 同时抢同一个保存动作。后续实现时应该明确优先级，比如 `prettierd -> prettier -> LSP fallback`。

### Debugging

前端 debug 暂时不作为第一阶段。真要配，再加：

- `mfussenegger/nvim-dap`
- JS debug adapter
- `nvim-dap-ui` 或其他轻量 UI

## Codex CLI 结合方式

我没有看到 OpenAI 官方提供一方 Neovim 插件。官方主要入口是：

- Codex CLI：终端 TUI、一次性 prompt、`codex exec`、`codex resume`。
- Codex IDE extension：VS Code/Cursor/Windsurf 集成。
- `AGENTS.md`：项目指令。
- MCP：把外部工具接入 Codex。

来源：

- https://developers.openai.com/codex/cli/features.md
- https://developers.openai.com/codex/cli/slash-commands.md
- https://developers.openai.com/codex/ide/features.md
- https://developers.openai.com/codex/guides/agents-md.md
- https://developers.openai.com/codex/mcp.md

建议的结合方式：

1. 终端里单独开一个 Codex pane，项目目录运行 `codex`。
2. 设置 `$EDITOR` / `$VISUAL` 为 `nvim`，Codex CLI prompt editor 可以进入 Neovim。
3. 在代码仓库放 `AGENTS.md`，把项目规范、测试命令、限制写进去。
4. 以后按需要给 Neovim 加一个很薄的 wrapper，例如 `:Codex` 打开 terminal buffer 跑 `codex`，或者 `:CodexExec` 调 `codex exec`。
5. 不建议一开始依赖第三方“AI Neovim 插件”承载 Codex 主流程。先让 Codex CLI 和 Neovim 各自稳定。

## 分阶段落地

### Phase 0：当前状态

已经完成：

- 无插件 baseline。
- Norman 映射保留。
- `~/.config/nvim` 指向这个仓库的 `nvim/`。

### Phase 1：插件管理 + LSP 基础

加入：

- `vim.pack` 结构
- `mason.nvim`
- `nvim-lspconfig`
- `blink.cmp`
- `which-key.nvim`

只启用 Lua/JSON/Markdown 这类低风险 server，验证架构没问题。

### Phase 2：前端开发

加入：

- `vtsls` 或 `typescript-language-server`
- `eslint`
- `html`
- `cssls`
- `tailwindcss`
- `conform.nvim`
- `nvim-lint`
- `fzf-lua`
- `yazi.nvim`
- `gitsigns.nvim`
- `trouble.nvim`

`fzf-lua` 和 `yazi.nvim` 本身是 Neovim 插件，但要发挥性能优势，外部工具也应该安装：

```sh
brew install yazi fzf ripgrep fd bat
```

当前映射：

| 快捷键 | 动作 |
| --- | --- |
| `<leader>e` | 打开 yazi，默认从当前 buffer/选中项进入 |
| `<leader>E` | 从当前工作目录打开 yazi |
| yazi 内 `<c-s>` | 用 `fzf-lua` 在当前目录或选中文件里 grep |

### Phase 3：Git TUI

安装 lazygit，先在外部终端用。确认快捷键和 Norman 布局后，再决定是否加 Neovim 内置打开方式。

### Phase 4：Java

单独按 Java 文档推进，不和前端栈一起一次性加。
