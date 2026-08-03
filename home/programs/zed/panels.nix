# Side panels: project tree, outline, collaboration, image/markdown preview.
{
  # ── Project panel ────────────────────────────────────────────────────────
  project_panel = {
    button = true;
    # "left" | "right"
    dock = "left";
    default_width = 240;
    starts_open = true;

    hide_gitignore = false;
    # Hides entries matching hidden_files (see files.nix).
    hide_hidden = false;
    hide_root = false;

    file_icons = true;
    folder_icons = true;
    bold_folder_labels = false;
    git_status = true;
    indent_size = 20;
    # "comfortable" | "standard"
    entry_spacing = "comfortable";

    auto_fold_dirs = true;
    auto_reveal_entries = true;
    sticky_scroll = true;

    # "directories_first" | "mixed" | "files_first"
    sort_mode = "directories_first";
    # "default" | "upper" | "lower" | "unicode"
    sort_order = "default";

    # "off" | "errors" | "all"
    show_diagnostics = "errors";
    diagnostic_badges = false;
    git_status_indicator = false;

    drag_and_drop = true;

    auto_open = {
      on_create = true;
      on_paste = false;
      on_drop = false;
    };

    indent_guides = {
      # "always" | "never"
      show = "always";
    };

    scrollbar = {
      # null inherits the editor setting.
      # "auto" | "system" | "always" | "never"
      show = null;
      horizontal_scroll = true;
    };
  };

  # ── Outline panel ────────────────────────────────────────────────────────
  outline_panel = {
    button = false;
    dock = "right";
    default_width = 300;

    file_icons = true;
    folder_icons = true;
    git_status = true;
    indent_size = 20;
    auto_fold_dirs = true;
    auto_reveal_entries = true;

    # 0 collapses every entry that has children.
    expand_outlines_with_depth = 100;

    indent_guides = {
      show = "always";
    };

    scrollbar = {
      show = null;
    };
  };

  # ── Collaboration panel ──────────────────────────────────────────────────
  collaboration_panel = {
    button = false;
    dock = "left";
    default_width = 240;
  };

  # ── Preview ──────────────────────────────────────────────────────────────
  image_viewer = {
    # "binary" | "decimal"
    unit = "binary";
  };

  markdown_preview = {
    limit_content_width = true;
    max_width = 800;
  };
}
