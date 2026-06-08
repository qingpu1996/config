# config

这个仓库放个人常用配置，主要用于重装系统或换机器后快速恢复工作环境。

当前重点是 macOS 上的 Neovim、lazygit 和输入法配置。其中输入法配置先保留现状，主要维护方向是 `nvim + LSP + Codex + lazygit` 的代码工作流。

## 目录

| 路径 | 说明 |
| --- | --- |
| `nvim/` | Neovim 配置，当前主力维护对象 |
| `lazygit/config.yml` | lazygit 配置，包含 Norman 布局适配 |
| `yazi/keymap.toml` | yazi 键位配置，包含 Norman 布局适配 |
| `input-method/` | Rime/Squirrel 相关输入法配置 |
| `docs/` | Neovim、lazygit、终端和 Java 工作流调研记录 |

## Neovim

### 安装位置

当前 Neovim 配置目录是：

```sh
~/Documents/config/nvim
```

本机通过软链接启用：

```sh
~/.config/nvim -> ~/Documents/config/nvim
```

如果新机器上还没有链接，可以用：

```sh
ln -sfn "$HOME/Documents/config/nvim" "$HOME/.config/nvim"
```

### 外部依赖

建议先安装这些命令行工具：

```sh
brew install neovim yazi lazygit fzf ripgrep fd bat
```

其中：

- `neovim`：编辑器本体。
- `yazi` / `ya`：文件管理器，由 `yazi.nvim` 调用。
- `lazygit`：Git TUI，由 `lazygit.nvim` 调用。
- `fzf`、`ripgrep`、`fd`、`bat`：给 `fzf-lua` 和搜索/预览提供性能基础。

### 配置结构

入口是 `nvim/init.lua`，加载顺序大致是：

1. `lua/config/options.lua`：基础选项，包含 leader、netrw 禁用等。
2. `lua/config/keymaps.lua`：通用快捷键。
3. `lua/config/norman.lua`：Norman 布局按键重映射。
4. `lua/config/autocmds.lua`：自动命令。
5. `lua/config/treesitter.lua`：使用 Neovim 内置 treesitter 高亮能力。
6. `lua/pack/init.lua`：`vim.pack` 插件管理和插件配置加载。

插件列表集中在：

```text
nvim/lua/pack/specs.lua
```

单个插件配置放在：

```text
nvim/lua/pack/configs/
```

### 插件管理

当前采用 Neovim 第一方 `vim.pack`，不用 `packer.nvim` 或 `lazy.nvim`。

常用命令：

| 命令 | 说明 |
| --- | --- |
| `:PackStatus` | 离线查看插件状态 |
| `:PackUpdate` | 更新全部插件或指定插件 |
| `:PackUpdate!` | 强制更新 |

lockfile 是：

```text
nvim/nvim-pack-lock.json
```

当前主要插件：

| 插件 | 用途 |
| --- | --- |
| `nvim-lspconfig` | LSP server config 来源 |
| `mason.nvim` / `mason-lspconfig.nvim` | 外部 LSP/formatter/linter 工具安装 |
| `blink.cmp` / `friendly-snippets` | 补全和 snippets |
| `conform.nvim` | 格式化 |
| `gitsigns.nvim` | Git hunk 信息 |
| `which-key.nvim` | 快捷键提示 |
| `fzf-lua` | 文件搜索、全文搜索、buffer、symbol、diagnostics |
| `yazi.nvim` | 在 Neovim 中打开 yazi，替代目录树 |
| `lazygit.nvim` | 在 Neovim 中打开 lazygit |
| `mini.nvim` | 小型基础增强组件 |
| `outline.nvim` | 符号大纲 |
| `undotree` | undo 历史查看 |

### 常用快捷键

`<leader>` 是空格。

通用：

| 快捷键 | 动作 |
| --- | --- |
| `S` | 保存 |
| `Q` | 退出 |
| `U` | redo |
| `<leader><cr>` | 清除搜索高亮 |
| `<S-Tab>` | 下一个 buffer |
| `<C-t>` | 当前 buffer 打开到新 tab |
| `X` | 删除当前 buffer |

窗口移动按 Norman 习惯配置：

| 快捷键 | 动作 |
| --- | --- |
| `<leader>w` | 下一个窗口 |
| `<leader>i` | 上方窗口 |
| `<leader>n` | 下方窗口 |
| `<leader>y` | 左侧窗口 |
| `<leader>o` | 右侧窗口 |

搜索和跳转：

| 快捷键 | 动作 |
| --- | --- |
| `<leader>se` | 搜索文件 |
| `<leader>sg` | live grep |
| `<leader>fw` | grep 当前光标单词 |
| `<leader>fb` | buffer 列表 |
| `<leader>fr` | 最近文件 |
| `<leader>fh` | help tags |
| `<leader>fl` | 当前 buffer 行搜索 |
| `<leader>fs` | 文档 symbols |
| `<leader>fS` | workspace symbols |
| `<leader>fd` | 当前文档 diagnostics |
| `<leader>fD` | workspace diagnostics |

文件和 Git：

| 快捷键 | 动作 |
| --- | --- |
| `<leader>e` | 打开 yazi |
| `<leader>E` | 从当前工作目录打开 yazi |
| yazi 内 `<c-s>` | 用 `fzf-lua` 在当前目录或选中文件里 grep |
| `<leader>lg` | 打开 lazygit |

Norman 布局的基础按键重映射在 `nvim/lua/config/norman.lua`，这里不展开完整表。后续如果某个插件和 Norman 冲突，优先在插件自己的 config 里处理。

### 健康检查

常用检查命令：

```sh
nvim --headless +qa
nvim --headless '+checkhealth yazi' +qa
nvim --headless '+checkhealth lazygit' +qa
```

## lazygit

lazygit 配置文件在：

```text
lazygit/config.yml
```

macOS 默认配置路径已设计为软链接到这个文件：

```text
~/Library/Application Support/lazygit/config.yml
```

这个配置主要做 Norman 布局适配。完整说明见：

- [lazygit 和 Norman 布局](docs/lazygit-norman-workflow.md)

## yazi

yazi 键位配置文件在：

```text
yazi/keymap.toml
```

macOS 默认配置路径已设计为软链接到这个文件：

```text
~/.config/yazi/keymap.toml
```

如果新机器上还没有链接，可以用：

```sh
mkdir -p ~/.config/yazi
ln -sfn "$HOME/Documents/config/yazi/keymap.toml" "$HOME/.config/yazi/keymap.toml"
```

这个配置主要做 Norman 布局适配，翻译原则和 lazygit 一致：

- 导航固定为 `i/n/y/o`（上/下/左/右），同时保留方向键 fallback。
- 被导航键挤掉的功能按 `nvim/lua/config/norman.lua` 的映射关系迁移：`yank → j`、`open → l`、`find next → p`、`rename → f`、`filter → t`。
- `[confirm]` 层的 `y`/`n`（yes/no）保持语义不变，只翻译导航键。
- `[input]` 层的 vim-like 模式做完整 Norman 翻译：`insert → r`、`word end → d`、`delete → e`。

完整配置以 `yazi/keymap.toml` 为准。使用中如果发现冲突，在 yazi 内按 `~` 查看当前面板的键位绑定。

## 文档

更多背景和后续计划见：

- [docs/README.md](docs/README.md)
- [Neovim LSP Codex 工作流](docs/nvim-lsp-codex-workflow.md)
- [Agent 时代终端工作流](docs/terminal-agent-workflow.md)
- [Java 开发接近 IDEA 的可行性](docs/java-idea-like-nvim.md)
