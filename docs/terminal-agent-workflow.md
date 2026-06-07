# Agent 时代终端工作流

调研时间：2026-06-08

## 本机当前状态

我在本机看到的状态：

- Homebrew formula 里有 `neovim`、`gh`、`node@24`、`python@3.12`、`python@3.14`、`ollama` 等。
- `lazygit` 已经通过 Homebrew 安装。
- `brew list --cask` 当前为空，也就是 Ghostty、WezTerm、Warp、iTerm2 这些 cask 都没有通过 Homebrew 安装。
- 之前这台机器上已经做过 zsh / Oh My Zsh / Powerlevel10k / Nerd Font 方向的终端美化，后续改 shell 配置时应该继续保留和备份已有 `~/.zshrc`。

## 结论

“Agent 时代大家最常用什么终端”没有一个绝对答案。真正重要的是终端要适合长时间跑 TUI：

- Neovim。
- Codex CLI。
- lazygit。
- 可能后续还有 tmux、fzf、ripgrep、bat、fd、jq。

我的建议是：

1. 如果想少折腾，先试 Ghostty。
2. 如果想终端也高度可配置，尤其你喜欢 Lua/Neovim 这套思路，试 WezTerm。
3. Warp 适合想体验内置 AI/blocks/workflows 的人，但它可能会和 Vim/TUI/键盘布局肌肉记忆产生摩擦，不建议作为你的默认第一选择。
4. iTerm2 仍然成熟，但这台机器上之前字体 profile 已经踩过一次坑。不是不能用，只是它不是这次最有增量的选择。

## 候选终端

### Ghostty

Ghostty 官方定位是 fast、feature-rich、cross-platform terminal emulator，使用 platform-native UI 和 GPU acceleration。它的文档也强调 zero configuration、tabs、splits、ligatures、auto-update、Kitty keyboard/graphics 相关能力。

适合你：

- 想从系统 Terminal.app 升级，但不想花很多时间写终端配置。
- 主要工作在 Neovim、Codex CLI、lazygit 这些 TUI 里。
- 想要 native macOS 体验。

注意点：

- Ghostty 使用自己的 terminfo，远程 SSH 机器如果没有对应 terminfo，可能需要处理 `xterm-ghostty` 兼容问题。

来源：

- https://ghostty.org/docs
- https://ghostty.org/docs/features
- https://ghostty.org/docs/help/terminfo

安装命令：

```sh
brew install --cask ghostty
```

### WezTerm

WezTerm 的特点是配置能力强，官方文档有完整 Lua config reference、keybinding、multiplexing、SSH、workspaces/sessions 等内容。

适合你：

- 想把终端配置也纳入 dotfiles。
- 想用 Lua 写 terminal 配置，和 Neovim 的思路接近。
- 后面可能需要比较复杂的 workspace/session/pane 行为。

注意点：

- 可配置性强也意味着初始配置成本更高。
- 如果你现在目标是快速建立 `nvim + codex + lazygit` 工作流，WezTerm 的高级能力可以先不碰。

来源：

- https://wezterm.org/

安装命令：

```sh
brew install --cask wezterm
```

### Warp

Warp 现在明显偏“AI/agent terminal”产品方向。它有自己的文档体系和 AI/command/workflow 体验。

适合你：

- 想试 AI-first terminal。
- 愿意接受更产品化、更非传统 terminal 的交互方式。

不作为默认推荐的原因：

- 你的核心工作流是 Norman 布局 + Neovim + CLI agent。
- Warp 的增强交互可能会改变传统 TUI 操作模型。
- 对长期 dotfiles 可迁移性来说，Ghostty/WezTerm 更朴素。

来源：

- https://docs.warp.dev/

安装命令：

```sh
brew install --cask warp
```

### iTerm2

iTerm2 仍然是 macOS 上成熟稳定的 Terminal.app 替代品。它功能足够多，生态材料多。

不作为这次第一推荐的原因：

- 它的增量主要是成熟度，不是 agent-era 的新工作流。
- 这台机器上之前 prompt 字体问题最终是 iTerm2 profile font 没切到 Nerd Font。继续用也可以，但要注意 profile 配置。

来源：

- https://iterm2.com/

安装命令：

```sh
brew install --cask iterm2
```

## 推荐工作流

第一版不要复杂化，先这样：

```text
Terminal window
├── tab/pane 1: nvim
├── tab/pane 2: codex
└── tab/pane 3: lazygit 或 shell
```

如果用 Ghostty：

- 用它自己的 tab/split 即可。
- 先不急着上 tmux。

如果用 WezTerm：

- 可以从普通 tab/split 开始。
- 后续再把 workspace/session 写进 `wezterm.lua`。

如果以后需要远程机器、长任务恢复、固定 session，再考虑 tmux。现在不建议一开始把 `tmux + terminal + nvim + codex + lazygit` 全部叠起来，因为排障面会变大。

## 和 Codex CLI 的关系

Codex CLI 官方入口就是终端 TUI，所以终端要优先满足：

- 长时间运行稳定。
- 快捷键不抢 Neovim / lazygit / Codex。
- 字体完整，Nerd Font 图标正常。
- copy/paste 不破坏多行命令和 TUI。
- 分屏或 tab 足够顺手。

建议后续设置：

```sh
export EDITOR=nvim
export VISUAL=nvim
```

这样 Codex CLI 的 prompt editor、Git commit editor、lazygit 外部编辑器都能统一回 Neovim。

## 下一步建议

我的推荐顺序：

1. `brew install --cask ghostty`
2. 设置字体为已安装的 Nerd Font，比如 `MesloLGS NF`。
3. 用 Ghostty 跑 `nvim`、`codex`、`gh`、`brew`，确认输入法、中文、复制粘贴、图标都正常。
4. 在 Neovim 里验证 `lazygit.nvim` 的 `<leader>lg` 入口。
5. 如果 Ghostty 不顺手，再试 WezTerm。
