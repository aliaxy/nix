# Task Plan — nix-darwin 配置扩展

## 目标
系统评估并引入对当前 nix-darwin 配置有价值的软件和配置。

## 现有配置摘要
- Shell: fish + starship
- 编辑器: nvim (dropbar/edgy/lualine/gitsigns) + zed
- 终端: ghostty
- 窗口管理: aerospace + jankyborders
- 文件管理: yazi
- CLI: bat, eza, zoxide, fastfetch, lazygit, direnv
- 开发: nil, nixd, claude-code, codex
- 主题: catppuccin 全局

## 评估维度
- 日常使用频率高
- 与现有工具链配合好
- home-manager 有一等支持
- 不与现有工具重复

---

## 当前任务 — 引入 sops-nix

### Step 1 — flake.nix 添加 input
- [ ] 添加 `sops-nix` input，`follows nixpkgs`

### Step 2 — home-manager 集成
- [ ] 在 `modules/darwin/home.nix` 中导入 `sops-nix.homeManagerModules.sops`

### Step 3 — 配置 age key
- [ ] 在 `home/profiles/dev.nix` 或新模块中配置 `sops.age.sshKeyPaths`
- [ ] 指向 `~/.ssh/id_ed25519_github`（age 可从 ed25519 SSH key 派生）

### Step 4 — 创建 .sops.yaml
- [ ] 获取当前机器 SSH 公钥对应的 age 公钥
- [ ] 创建 `secrets/.sops.yaml`，配置 air-m4 的 key

### Step 5 — 创建 secrets 目录结构
- [ ] 创建 `secrets/` 目录
- [ ] 加入 `.gitignore` 排除未加密文件（只提交 `.age` 文件）

### Step 6 — 验证
- [ ] `darwin-rebuild switch` 确认无报错
- [ ] 创建一个测试 secret 验证解密正常

---

## Backlog — 后续引入

### CLI 体验提升
- [ ] atuin — shell history 数据库
- [ ] fzf — 模糊查找
- [ ] delta — git diff 美化
- [ ] gh — GitHub CLI
- [ ] ripgrep / fd — 搜索加速

### Nix 工具链
- [ ] alejandra — nix 格式化
- [ ] nix-index-database — 包文件索引

### macOS 体验
- [ ] sketchybar — 自定义状态栏（配合 aerospace）

## 决策记录
| 工具 | 决策 | 原因 |
|---|---|---|
| borders | 已有 (jankyborders) | 重复 |
| agenix | 替换为 sops-nix | 多机器场景更灵活 |
| skhd | 不引入 | 与 aerospace keybindings 重叠 |
