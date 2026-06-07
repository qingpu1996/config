# 开发工作流调研索引

调研时间：2026-06-08

这个目录记录下一步把当前极简 Neovim 配置扩展成 `nvim + LSP + Codex + lazygit` 工作流的判断依据。当前仓库里 Neovim 配置已经先收敛成无插件 baseline，后续加插件建议按阶段推进，不建议一次性恢复成一个大而全的配置。

## 文档

- [Neovim LSP Codex 工作流](./nvim-lsp-codex-workflow.md)：包管理器、基础插件、前端开发插件、Codex CLI 的结合方式。
- [Agent 时代终端工作流](./terminal-agent-workflow.md)：Terminal.app 之外的终端选择，以及适合 CLI agent 的终端组织方式。
- [lazygit 和 Norman 布局](./lazygit-norman-workflow.md)：lazygit 是否值得用、快捷键能不能改、怎么和 Neovim 结合。
- [Java 开发接近 IDEA 的可行性](./java-idea-like-nvim.md)：Neovim Java 能做到什么，和 IDEA 差在哪里，建议分阶段怎么配。

## 总体建议

我的建议是：

1. Neovim 插件管理先用第一方 `vim.pack`，不要回到 `packer.nvim`。
2. LSP 走 Neovim 0.11+ 的 `vim.lsp.config()` / `vim.lsp.enable()` 思路，`nvim-lspconfig` 只作为社区 server config 来源。
3. 前端先配 TypeScript/ESLint/Prettier/Tailwind 这一条主线，Java 单独作为第二阶段。
4. Codex 不强行找 Neovim 插件嵌死，先作为终端里的 CLI agent 使用，再用 `$EDITOR`、`AGENTS.md`、MCP、Neovim terminal/lazygit 工作流连接起来。
5. 终端建议先试 Ghostty 或 WezTerm；如果你想要最少配置，选 Ghostty；如果你想把终端也纳入 Lua 配置体系，选 WezTerm。
6. lazygit 值得用，但 Norman 快捷键需要小步调整，先保留默认键，再补 Norman 导航键，避免破坏 Git 操作肌肉记忆。
