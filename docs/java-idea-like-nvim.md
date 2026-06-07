# Java 开发接近 IDEA 的可行性

调研时间：2026-06-08

## 结论

Neovim 可以把 Java 开发配置到“日常可用，接近 IDE 工作流”的程度，但不能完全等价于 IntelliJ IDEA。

可以接近的部分：

- completion。
- go to definition/references/implementation/type definition。
- hover/Javadoc。
- diagnostics。
- code actions。
- organize imports。
- formatting。
- Maven/Gradle project import。
- test run/debug。
- DAP debugging。
- Spring Boot 基础支持。
- decompiler。

难以完全追平 IDEA 的部分：

- 深度 refactoring。
- 大型企业 Java 项目的索引和项目模型体验。
- Spring/框架级智能提示和导航。
- 测试 UI、调试 UI、build tool UI 的整体打磨。
- 复杂 multi-module 项目的稳定性和排障体验。
- IDEA inspection 生态。

所以答案是：能做到很强，但不要期待完全替代 IDEA。更现实的定位是：Neovim 作为主编辑器，Java 深活或复杂重构时保留 IDEA 兜底。

## Java LSP 的核心是 JDT LS

Eclipse JDT Language Server 是 Java LSP 的核心。它支持 Maven、Gradle、standalone Java 文件、completion、Javadoc hover、organize imports、code actions/refactorings、outline、folding、navigation、code lens、formatting、semantic highlighting、call hierarchy、type hierarchy 等。

它现在运行时至少需要 Java 21。

来源：

- https://github.com/eclipse-jdtls/eclipse.jdt.ls

## Neovim 里的两条路线

### 路线 A：nvim-java

`nvim-java` 的定位是 Painless Java in Neovim。它把很多 Java 开发所需部件打包起来，包括：

- Spring Boot Tools。
- Diagnostics & Auto Completion。
- Automatic Debug Configuration。
- Organize Imports & Code Formatting。
- Running Tests。
- Run & Debug Profiles。
- Application Runner with Log Viewer。
- Decompiler Support。
- Code Actions。

它的安装示例已经使用 `vim.lsp.enable('jdtls')`，符合 Neovim 新 LSP 方向。它也说明自身会加载 `java-test`、`java-debug-adapter`、Spring Boot tools 等扩展。

适合你：

- 想少写 Java 配置。
- 想快速得到接近 IDE 的 Java 功能。
- 接受一个插件帮你管理较多 Java 子组件。

来源：

- https://github.com/nvim-java/nvim-java

### 路线 B：nvim-jdtls

`nvim-jdtls` 更适合想自己掌控 JDT LS 配置的人。它能和 `nvim-dap` 集成，配置 java-debug 和 vscode-java-test bundles 后，可以 debug application、自动发现 main class、debug JUnit tests。

适合你：

- 想精确控制 `jdtls` 启动参数、workspace data、runtime、bundles。
- 愿意花时间排 JDT LS 配置问题。
- 不想把 Java 体验交给更大的 bundle 插件。

来源：

- https://github.com/mfussenegger/nvim-jdtls

## 我建议怎么选

对你这套配置，我建议先选 `nvim-java`，原因：

- 你现在刚把配置清成 baseline，不应该一开始就写一大段 `jdtls` 手工启动配置。
- 你目标是 “nvim + LSP + Codex 的代码工作流”，不是先陷入 Java LSP 排障。
- `nvim-java` 当前 README 已经适配 `vim.lsp.enable('jdtls')`。
- 如果以后发现它过重或行为不合预期，再降级到 `nvim-jdtls` 手工配置。

## Java 插件组合建议

第一版：

| 层级 | 建议 |
| --- | --- |
| LSP | `jdtls` |
| Neovim Java glue | `nvim-java` |
| DAP | `nvim-dap` |
| Completion | `blink.cmp` |
| Formatter | JDT LS formatting 或 `conform.nvim` fallback |
| Diagnostics UI | `trouble.nvim` |
| Fuzzy/LSP action | `snacks.picker` |

如果选择 `nvim-jdtls` 手工路线，还需要处理：

- `java-debug` bundle。
- `vscode-java-test` bundle。
- 每个项目独立的 JDT LS workspace data directory。
- 多 JDK runtimes。
- Maven/Gradle 项目 language level。

`vscode-java-debug` 本身支持 launch/attach、breakpoints、exceptions、step in/out/over、variables、callstacks、threads、debug console、evaluation、hot code replace 等能力。Neovim 通过 `nvim-dap` 和对应 bundle 接上。

来源：

- https://github.com/microsoft/vscode-java-debug

## 和 IDEA 的差距

### 能接近

| 能力 | Neovim 可行性 |
| --- | --- |
| 补全 | 高 |
| 跳转 | 高 |
| diagnostics | 高 |
| hover/Javadoc | 高 |
| organize imports | 高 |
| formatting | 高 |
| Maven/Gradle import | 中高 |
| debug | 中高 |
| test run/debug | 中高 |
| Spring Boot 基础支持 | 中 |
| decompile | 中 |

### 难追平

| 能力 | 原因 |
| --- | --- |
| 大型项目索引体验 | IDEA 的项目模型和索引是核心优势 |
| 复杂 refactoring | LSP code action 能做一部分，但不是 IDEA 级别 |
| Spring/框架智能 | IDEA Ultimate 的框架支持很深 |
| 调试/测试 UI | Neovim DAP UI 可用，但打磨程度不同 |
| build tool 图形化体验 | Gradle/Maven UI 不是 Neovim 强项 |
| inspection 生态 | IDEA inspection 和 quick fix 更全面 |

## 分阶段落地

### Phase 1：先把非 Java LSP 架构跑稳

先完成：

- `vim.pack`
- `mason.nvim`
- `nvim-lspconfig`
- `blink.cmp`
- `conform.nvim`
- `trouble.nvim`

只启用轻量语言，确认 LSP 基础设施正常。

### Phase 2：安装 Java 基础依赖

需要：

```sh
brew install openjdk
```

但 JDT LS 当前要求 Java 21+ runtime。安装命令具体用 `openjdk` 还是 `openjdk@21`，后续实装时应先看 Homebrew 当前 formula 状态。

### Phase 3：接入 nvim-java

插件：

```lua
{
  "nvim-java/nvim-java",
  config = function()
    require("java").setup()
    vim.lsp.enable("jdtls")
  end,
}
```

这只是方向示例，不建议现在直接贴进配置。真正加入时要和 `vim.pack`、`mason.nvim`、`blink.cmp` 的结构一起落地。

### Phase 4：debug/test

确认：

- main class 能被发现。
- JUnit test 能 run。
- JUnit test 能 debug。
- breakpoint / step / variables 正常。

### Phase 5：保留 IDEA 兜底

建议保留 IDEA 用于：

- 大型重构。
- Spring/企业框架复杂功能。
- build/import 疑难问题。
- 需要图形化 debugger/test runner 的场景。

Neovim 不必在第一天就承担所有 Java 重活。
