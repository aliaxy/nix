# home-manager 配置入口
# 由 hosts/air-m4/default.nix 通过 home-manager.users.aliaxy 引用
{ inputs, ... }:
{
  imports = [
    # Catppuccin home-manager 模块（由 inputs 注入）
    inputs.catppuccin.homeModules.catppuccin
    # 主题变量
    ../themes/catppuccin.nix
    # 功能分层 profile
    ./profiles/base.nix
    ./profiles/dev.nix
    ./profiles/desktop.nix
  ];

  home.stateVersion = "25.11";
}
