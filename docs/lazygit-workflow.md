# lazygit 工作流

调研时间：2026-06-08

## 结论

`lazygit` 适合作为这个配置仓库里的终端 Git 管理工具。它是成熟的 Git TUI，项目活跃度和社区使用量都足够高，既可以独立在终端里使用，也可以通过 `lazygit.nvim` 从 Neovim 里打开。

本分支面向 QWERTY 用户，不覆盖 lazygit 默认键位；当前只在 `lazygit/config.yml` 里保留 Catppuccin Mocha Mauve 主题。

## 安装

```sh
brew install lazygit
```

## 配置文件位置

macOS 默认全局配置路径：

```text
~/Library/Application Support/lazygit/config.yml
```

本仓库的配置文件是：

```text
lazygit/config.yml
```

建议用软链接启用：

```sh
mkdir -p "$HOME/Library/Application Support/lazygit"
ln -sfn "$HOME/Documents/config/lazygit/config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
```

来源：

- https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
- https://lazygit.dev/docs/configuration/

## 当前配置

当前 `lazygit/config.yml` 只做两类事情：

- 使用 Catppuccin Mocha Mauve 主题。
- 预留未来接入 AI 生成 commit message 的位置。

默认 QWERTY 键位保持 lazygit 原生行为。常用键：

| 快捷键 | 动作 |
| --- | --- |
| `j` / `k` | 下/上移动 |
| `h` / `l` | 左/右切换面板 |
| `<tab>` / `<backtab>` | 切换面板 |
| `?` | 查看当前面板 keybindings |
| `c` | commit |
| `P` / `p` | push / pull |
| `s` | stash |

## Neovim 集成

当前已经接入 `kdheepak/lazygit.nvim`，由 `vim.pack` 管理，并用 `<leader>lg` 在 Neovim 浮窗中打开 lazygit。

如果后续发现嵌入浮窗在 focus、复制、窗口大小或快捷键上不如独立终端稳定，可以继续保留 lazygit 本体作为完整 TUI，在外部终端里使用。

来源：

- https://github.com/kdheepak/lazygit.nvim

## AI commit message TODO

后续可以用 lazygit 官方 `customCommands` 接一个生成 commit message 的命令：

1. 在 `files` 面板按自定义快捷键。
2. 脚本读取 `git diff --cached`，只总结已 staged 的改动。
3. 调用 `codex exec` 或 Claude CLI 生成一条短 commit message。
4. lazygit input prompt 预填结果，人工确认或微调。
5. 执行 `git commit -m ...`。

这个方案不需要修改 lazygit 本体，保持 TUI 工作流轻量。

## 推荐 Git 工作流

```text
Neovim: 编辑、LSP、diagnostics、quickfix
gitsigns.nvim: 当前 buffer 的 hunk 级查看/临时 stage/reset
lazygit: commit、branch、stash、rebase、push/pull、历史查看
gh: PR/issue、GitHub 操作
Codex CLI: review、diff、改动解释、自动修复
```

后续 Neovim 内可选集成：

- `gitsigns.nvim`：必装，轻量，负责 buffer 内 Git 信号。
- `lazygit.nvim`：当前采用，`<leader>lg` 在 Neovim 浮窗中打开 lazygit。
- `diffview.nvim`：可选，负责复杂 diff/review。
