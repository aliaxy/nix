# Appearance: theme, fonts, text rendering, accessibility.
{
  # ── Theme ────────────────────────────────────────────────────────────────
  # Owned by home/catppuccin.nix (catppuccin-nix injects these into
  # userSettings); setting them here would conflict.
  # mode: "system" | "light" | "dark"
  # theme = {
  #   mode = "system";
  #   light = "One Light";
  #   dark = "One Dark";
  # };
  # icon_theme = "Zed (Default)";

  # ── Buffer font ──────────────────────────────────────────────────────────
  buffer_font_family = "JetBrainsMono Nerd Font";

  # Merged with the platform fallback chain, not a replacement.
  buffer_font_fallbacks = [
    "PingFang SC"
    "Apple Symbols"
  ];

  buffer_font_features = {
    calt = true;
  };

  buffer_font_size = 13;
  buffer_font_weight = 400; # 100–900

  # "comfortable" (1.618) | "standard" (1.3) | { custom = 2; }
  buffer_line_height = "comfortable";

  # ── UI font ──────────────────────────────────────────────────────────────
  ui_font_family = ".SystemUIFont";
  ui_font_fallbacks = [
    "PingFang SC"
    "Apple Symbols"
  ];
  ui_font_features = {
    calt = false;
  };
  ui_font_weight = 500; # 100–900
  ui_font_size = 13;

  # ── Per-area font sizes ──────────────────────────────────────────────────
  # null falls back to ui_font_size / buffer_font_size.
  agent_ui_font_size = null;
  agent_buffer_font_size = 13;
  git_commit_buffer_font_size = 13;

  markdown_preview_font_size = null;
  markdown_preview_font_family = null;
  markdown_preview_code_font_family = null;

  # ── Text rendering and contrast ──────────────────────────────────────────
  # "platform_default" | "subpixel" | "grayscale"
  text_rendering_mode = "platform_default";

  unnecessary_code_fade = 0.3;

  # APCA perceptual contrast, 0–106; 0 disables adjustment.
  # 45 large text, 60 content text, 75 body text, 90 preferred body text.
  minimum_contrast_for_highlights = 45;

  # ── Motion and accessibility ─────────────────────────────────────────────
  # "on" | "off"
  reduce_motion = "off";

  accessible_mode = false;

  # ── Window decorations ───────────────────────────────────────────────────
  # "client" | "server"; requires restart.
  window_decorations = "client";

  zoomed_padding = true;
}
