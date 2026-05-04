# Findings — nix-darwin 配置扩展调研

## sops-nix 引入方案

### 架构决策
- nix-darwin 没有官方 sops 系统模块（那是 NixOS 的），使用 `sops-nix.homeManagerModules.sops`
- age 后端：直接从现有 SSH ed25519 key（`~/.ssh/id_ed25519_github`）派生，无需额外 age key 文件
- secrets 存放在 `secrets/` 目录，以 `.age` 加密文件提交，明文永远不入 git

### flake input 写法
```nix
sops-nix.url = "github:Mic92/sops-nix";
sops-nix.inputs.nixpkgs.follows = "nixpkgs";
```

### home-manager 模块导入位置
在 `modules/darwin/home.nix` 的 `home-manager.users.${username}.imports` 中添加：
```nix
inputs.sops-nix.homeManagerModules.sops
```

### sops 配置
```nix
sops = {
  defaultSopsFile = ../secrets/secrets.yaml;
  age.sshKeyPaths = [ "/Users/${username}/.ssh/id_ed25519_github" ];
};
```

### 获取 age 公钥（用于 .sops.yaml）
```bash
nix-shell -p ssh-to-age --run 'ssh-to-age < ~/.ssh/id_ed25519_github.pub'
```

### .sops.yaml 结构（多机器）
```yaml
keys:
  - &air-m4 age1xxxx...   # air-m4 的 age 公钥

creation_rules:
  - path_regex: secrets/.*\.yaml$
    key_groups:
      - age:
          - *air-m4
```

### 注意事项
- `sops.secrets.<name>.path` 默认在 `/run/user/<uid>/secrets/`（macOS 上路径不同，需确认）
- home-manager sops 模块在 macOS 上 secrets 路径为 `~/.config/sops-nix/secrets/`
- 首次加密需要在有私钥的机器上执行 `sops secrets/secrets.yaml`

---

## CLI 工具

### atuin
- home-manager 有 `programs.atuin`，fish 集成完善
- 替换默认 history，支持模糊搜索、跨机器同步、统计
- **推荐引入**

### fzf
- home-manager 有 `programs.fzf`，有 fish integration
- 很多工具会自动检测并接入（nvim telescope 可用、yazi 可用）
- **推荐引入**

### delta
- home-manager 有 `programs.git.delta`，直接在 git 配置里启用
- 替换 git diff/log 的输出渲染，支持 catppuccin 主题
- **推荐引入**

### gh
- home-manager 有 `programs.gh`
- 与 lazygit 互补：lazygit 管本地 git 操作，gh 管 PR/issue/release
- **推荐引入**

### ripgrep / fd
- nixpkgs 有，常作为 `home.packages` 引入
- nvim telescope 默认依赖 ripgrep；yazi 可配置使用 fd
- **推荐引入**

---

## Nix 工具链

### alejandra
- nixpkgs 有，比 nixfmt 更 opinionated，格式化结果一致性好
- **推荐引入**

### nix-index-database
- 提供预构建索引，避免本地 `nix-index` 耗时重建
- home-manager 模块：`nix-index-database.hmModules.nix-index`
- **值得引入**，需要额外 input

---

## macOS 体验

### sketchybar
- 高度可定制状态栏，aerospace 用户常见搭配
- 配置复杂，nix-darwin 有 `services.sketchybar` 支持
- **可选**，需要较多配置投入

### skhd
- 全局热键守护进程，aerospace 本身已有 keybindings
- 重叠度高，**不引入**
