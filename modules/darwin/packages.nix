# macOS 系统级软件包、Shell 及字体
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mas
    keka
    ghostty-bin
    nixd
    nil
    uv
    rustup
    fnm
  ];

  environment.shells = [ pkgs.fish ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # 让 nix-darwin 管理 fish（注册到 /etc/shells 等）
  programs.fish.enable = true;
}
