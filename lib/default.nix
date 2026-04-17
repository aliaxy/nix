# lib/default.nix — 封装函数，让 flake.nix 保持简洁
# 用法：let lib = import ./lib { inherit inputs self; }; in lib.mkDarwinHost { ... }
{ inputs, self }:
{
  # 构建一个 nix-darwin 主机配置
  # 参数:
  #   hostname      — hosts/ 下的子目录名（必填）
  #   system        — 目标架构，默认 "aarch64-darwin"
  #   extraModules  — 额外 NixOS 模块列表（可选）
  mkDarwinHost =
    {
      hostname,
      system ? "aarch64-darwin",
      extraModules ? [ ],
    }:
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs self; };
      modules = [
        (../hosts + "/${hostname}")
        inputs.nix-homebrew.darwinModules.nix-homebrew
        inputs.home-manager.darwinModules.home-manager
      ]
      ++ extraModules;
    };
}
