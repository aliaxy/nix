# desktop profile — 图形环境专属：终端、编辑器、窗口管理器
{ ... }:
{
  imports = [
    ../programs/ghostty.nix
    ../programs/zed.nix
    ../programs/aerospace.nix
  ];
}
