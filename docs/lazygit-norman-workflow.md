# lazygit 和 Norman 布局

调研时间：2026-06-08

## 结论

`lazygit` 现在很值得作为终端 Git 管理工具使用。它是成熟的 Git TUI，项目活跃度和社区使用量都足够高。它的快捷键可以自定义，也有 Neovim 插件能从编辑器里打开 lazygit。

但对你的 Norman 布局来说，不建议一上来重写所有 lazygit 快捷键。更稳的路线是：

1. 先安装 lazygit，在外部终端用默认键体验一段时间。
2. 只给导航加 Norman 友好的替代键。
3. 确认没有和 Git 操作键冲突后，再写正式 `config.yml`。
4. 最后再决定是否放进 Neovim 浮窗或 terminal buffer。

## 安装

当前本机没有安装 `lazygit`。安装命令：

```sh
brew install lazygit
```

## 配置文件位置

lazygit 官方 GitHub 配置文档写到 macOS 默认全局配置在：

```text
~/Library/Application Support/lazygit/config.yml
```

如果设置了 `XDG_CONFIG_HOME`，也可以走 XDG 路径。lazygit 文档站也提到 `~/.config/lazygit/config.yml` 和 `$XDG_CONFIG_HOME/lazygit/config.yml`。

后续如果要把 lazygit 配置纳入这个 repo，建议做法是：

- 在仓库里放 `lazygit/config.yml`。
- 再把 macOS lazygit 配置路径软链接到仓库文件。
- 不建议直接让整个 `~/Library/Application Support` 进入 dotfiles 管理。

来源：

- https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
- https://lazygit.dev/docs/configuration/

## 快捷键能不能改

可以。lazygit 的 `keybinding` section 支持替换默认键，也支持添加 alt 形式的替代键。官方 Config 里还直接给了 Colemak 用户的示例，说明它本来就考虑过非 QWERTY 布局。

默认导航里，常见键是：

```yaml
keybinding:
  universal:
    prevItem: [<up>, k]
    nextItem: [<down>, j]
    prevBlock: [<left>, h, <backtab>]
    nextBlock: [<right>, l, <tab>]
    nextMatch: "n"
    prevMatch: "N"
```

来源：

- https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md

## 你的 Norman 映射

当前 Neovim 里 Norman 导航语义是：

| 语义 | 当前按键 |
| --- | --- |
| 左 | `y` |
| 下 | `n` |
| 上 | `i` |
| 右 | `o` |
| search next | `p` |
| search previous | `P` |

对应来自 `nvim/lua/config/norman.lua`：

```lua
y = "h"
n = "j"
i = "k"
o = "l"
p = "n"
P = "N"
```

## lazygit Norman 配置

当前已经在仓库里落地了 lazygit 配置：

```text
lazygit/config.yml
```

macOS lazygit 默认配置路径已经软链接到这个文件：

```text
~/Library/Application Support/lazygit/config.yml
```

原来的空配置文件已备份为：

```text
~/Library/Application Support/lazygit/config.yml.codex-backup-20260608-030317
```

当前版本采用“系统性 Norman 翻译”，不只是把冲突键临时挪到大写或 Ctrl 组合：

- 导航层固定为 `i/n/y/o`，同时保留方向键 fallback。
- 大部分动作键按 `nvim/lua/config/norman.lua` 的反向关系做 QWERTY -> Norman 迁移，例如 `d -> e`、`e -> d`、`r -> f`、`f -> t`、`p -> h`、`o -> l`。
- lazygit 的 search match 没有沿用 Neovim 的 `p/P`，而是参考官方 Colemak 示例使用 `=` / `-`，因为 `p/P` 在 lazygit 里会牵连 `new`、`pull`、`push` 这些 Git 动作。

当前映射：

```yaml
keybinding:
  universal:
    prevItem: '<up>'
    nextItem: '<down>'
    prevItem-alt: 'i'
    nextItem-alt: 'n'
    prevBlock: '<left>'
    nextBlock: '<right>'
    prevBlock-alt: 'y'
    nextBlock-alt: 'o'
    nextMatch: '='
    prevMatch: '-'
    scrollUpMain-alt1: 'I'
    scrollDownMain-alt1: 'N'
    remove: 'e'
    new: 'p'
    edit: 'd'
    openFile: 'l'
    pushFiles: 'H'
    pullFiles: 'h'

  files:
    ignoreFile: 'r'
    refreshFiles: 'f'
    fetch: 't'
    copyFileInfoToClipboard: 'j'

  branches:
    createPullRequest: 'l'
    viewPullRequestOptions: 'L'
    rebaseBranch: 'f'
    renameBranch: 'F'
    viewGitFlowOptions: 'r'
    fastForward: 't'
    pushTag: 'H'

  commits:
    renameCommit: 'f'
    markCommitAsFixup: 't'
    moveDownCommit: ['N', '<alt-down>']
    moveUpCommit: ['I', '<alt-up>']
    pickCommit: 'h'
    revertCommit: 'k'
    openInBrowser: 'l'
    startInteractiveRebase: 'r'

  submodules:
    init: 'r'

  main:
    prevHunk: ['<left>', 'y']
    nextHunk: ['<right>', 'o']
```

完整配置以 `lazygit/config.yml` 为准。上面只列常用和最容易冲突的部分。

仍然建议做一次实际面板级测试：

- 在 lazygit 内按 `?` 看当前 panel 的 keybindings。
- 如果某个 Git 动作比 Norman 导航更常用，再针对那个 panel 微调。

## Neovim 里有没有插件

有。`kdheepak/lazygit.nvim` 是专门在 Neovim 里调用 lazygit 的插件，支持 `:LazyGit`、`:LazyGitCurrentFile` 等命令。它的 README 里给了 `lazy.nvim` 示例，但用 `vim.pack` 安装也没有本质障碍。

来源：

- https://github.com/kdheepak/lazygit.nvim

但我的建议是先不要急着装插件：

1. 先把 lazygit 作为独立终端 TUI 用顺。
2. 确认 Norman 快捷键配置。
3. 再决定是否集成到 Neovim。

原因是 lazygit 本身已经是完整 TUI。把它嵌进 Neovim 浮窗之后，可能出现终端 nested TUI、focus、复制、窗口大小、快捷键冲突等额外问题。你的目标是形成可靠工作流，不是为了插件而插件。

## 推荐 Git 工作流

短期：

```text
Neovim: 编辑、LSP、diagnostics、quickfix
gitsigns.nvim: 当前 buffer 的 hunk 级查看/临时 stage/reset
lazygit: commit、branch、stash、rebase、push/pull、历史查看
gh: PR/issue、GitHub 操作
Codex CLI: review、diff、改动解释、自动修复
```

后续 Neovim 内可选集成：

- `gitsigns.nvim`：必装，轻量，负责 buffer 内 Git 信号。
- 内置 terminal：当前采用，`<leader>g` 在新 tab 中运行 `lazygit`，不额外依赖插件。
- `lazygit.nvim`：可选替代，只负责从 Neovim 打开 lazygit。
- `diffview.nvim`：可选，负责复杂 diff/review。

我的建议是先只上 `gitsigns.nvim + 外部/内置 terminal lazygit`。
