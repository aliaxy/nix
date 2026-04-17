# Nix 守护进程 / 核心设置（跨平台通用）
{ ... }:
{
  nix.settings.experimental-features = "nix-command flakes";
}
