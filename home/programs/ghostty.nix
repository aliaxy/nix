# Ghostty 终端模拟器
{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    package = null; # 由 Homebrew cask 管理
    settings = {
      language = "en";

      font-family = "JetBrainsMono Nerd Font, PingFang SC";
      font-style = "default";
      font-synthetic-style = false;
      font-feature = "liga";
      font-size = 12;

      adjust-cell-width = 0;
      adjust-cell-height = 0;
      adjust-font-baseline = 0;

      cursor-style = "bar";
      cursor-style-blink = true;

      background-opacity = 0.95;
      background-blur-radius = 20;

      window-decoration = true;
      window-title-font-family = "";
      window-padding-x = 12;
      window-padding-y = 10;
      window-padding-balance = true;
      window-step-resize = true;
      window-save-state = "default";
      macos-icon = "official";
      macos-titlebar-style = "tabs";
      window-colorspace = "display-p3";
      window-padding-color = "extend";
    };
  };
}
