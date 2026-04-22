# Ghostty terminal emulator — managed by Home Manager, installed via Homebrew cask.
{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    package = pkgs.ghostty-bin;

    settings = {
      language = "en";

      # ── Font ────────────────────────────────────────────────────────────────
      font-family = "JetBrainsMono Nerd Font, PingFang SC";
      font-style = "default";
      font-synthetic-style = false; # disable faux bold/italic
      font-feature = "liga"; # enable ligatures
      font-size = 12;

      # Fine-tune cell metrics (0 = no adjustment).
      adjust-cell-width = 0;
      adjust-cell-height = 0;
      adjust-font-baseline = 0;

      # ── Cursor ──────────────────────────────────────────────────────────────
      cursor-style = "bar";
      cursor-style-blink = true;

      # ── Background ──────────────────────────────────────────────────────────
      background-opacity = 0.95;
      background-blur-radius = 20;

      # ── Window ──────────────────────────────────────────────────────────────
      window-decoration = true;
      window-title-font-family = ""; # inherit from font-family
      window-padding-x = 12;
      window-padding-y = 10;
      window-padding-balance = true; # keep padding symmetric across splits
      window-step-resize = true; # snap resize to cell boundaries
      window-save-state = "default";
      window-colorspace = "display-p3"; # wide-gamut colour on Apple displays
      window-padding-color = "extend"; # extend terminal background into padding

      # ── macOS ────────────────────────────────────────────────────────────────
      macos-icon = "official";
      macos-titlebar-style = "tabs"; # show tabs in the native title bar
    };
  };
}
