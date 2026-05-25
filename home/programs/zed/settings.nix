{
  # ── Buffer font ─────────────────────────────────────────────────────────
  buffer_font_family = "JetBrainsMono Nerd Font";
  buffer_font_fallbacks = [
    "JetBrainsMono Nerd Font"
    "PingFang SC"
    "Apple Symbols"
  ];
  buffer_font_size = 13;
  buffer_font_weight = 400;

  # ── UI font ──────────────────────────────────────────────────────────────
  ui_font_family = ".SystemUIFont";
  ui_font_fallbacks = [
    "JetBrainsMono Nerd Font"
    "PingFang SC"
    "Apple Symbols"
  ];
  ui_font_weight = 500;
  ui_font_size = 13;

  # ── Pane / layout ────────────────────────────────────────────────────────
  active_pane_modifiers = {
    border_size = 0.8;
    inactive_opacity = 1.0;
  };

  # ── Editor behaviour ─────────────────────────────────────────────────────
  use_system_path_prompts = true;
  use_system_prompts = true;
  current_line_highlight = "gutter";
  auto_signature_help = false;
  use_system_window_tabs = false;
  formatter = "language_server";
  tab_size = 2;
  auto_update = false; # updates are managed externally via Homebrew
  always_treat_brackets_as_autoclosed = true;

  # ── Title bar ────────────────────────────────────────────────────────────
  title_bar = {
    show_branch_name = true;
    show_project_items = true;
    show_onboarding_banner = true;
    show_user_picture = true;
    show_sign_in = true;
    show_menus = false;
  };

  # ── Scrollbar ────────────────────────────────────────────────────────────
  scrollbar = {
    axes = {
      horizontal = false;
      vertical = true;
    };
  };

  # ── Gutter ───────────────────────────────────────────────────────────────
  gutter = {
    min_line_number_digits = 2;
  };

  # ── Indent guides ────────────────────────────────────────────────────────
  indent_guides = {
    coloring = "indent_aware";
  };

  # ── Search ───────────────────────────────────────────────────────────────
  search = {
    button = true;
    whole_word = false;
    case_sensitive = false;
    include_ignored = false;
    regex = true;
    center_on_match = false;
  };

  # ── Inlay hints ──────────────────────────────────────────────────────────
  inlay_hints = {
    enabled = true;
    show_type_hints = false;
    show_parameter_hints = true;
    show_value_hints = true;
    show_other_hints = true;
    show_background = false;
    edit_debounce_ms = 700;
    scroll_debounce_ms = 50;
    toggle_on_modifiers_press = {
      control = false;
      shift = false;
      alt = false;
      platform = false;
      function = false;
    };
  };

  # ── Panels ───────────────────────────────────────────────────────────────
  collaboration_panel = {
    button = false;
    dock = "left";
    default_width = 240;
  };

  # ── AI agent ─────────────────────────────────────────────────────────────
  agent = {
    default_profile = "write";
    default_model = {
      effort = "medium";
      provider = "zed.dev";
      model = "gpt-5.4";
      enable_thinking = true;
    };
    favorite_models = [ ];
    model_parameters = [ ];
  };

  # ── Tab bar ──────────────────────────────────────────────────────────────
  tab_bar = {
    show = true;
    show_nav_history_buttons = true;
    show_tab_bar_buttons = false;
  };

  tabs = {
    git_status = true;
    close_position = "right";
    file_icons = true;
    show_diagnostics = "all";
  };

  preview_tabs = {
    enabled = true;
    enable_preview_from_file_finder = true;
    enable_preview_file_from_code_navigation = true;
  };

  # ── Telemetry ────────────────────────────────────────────────────────────
  telemetry = {
    diagnostics = false;
    metrics = false;
  };

  # ── Diagnostics ──────────────────────────────────────────────────────────
  diagnostics = {
    inline = {
      enabled = true;
      update_debounce_ms = 150;
      padding = 2;
      min_column = 0;
      max_severity = null;
    };
  };

  # ── Edit predictions (AI completions) ────────────────────────────────────
  edit_predictions = {
    provider = "zed";
    # Never send secrets or credentials to the prediction backend.
    disabled_globs = [
      "**/.env*"
      "**/*.pem"
      "**/*.key"
      "**/*.cert"
      "**/*.crt"
      "**/.dev.vars"
      "**/secrets.yml"
      "**/.zed/settings.json"
      "/**/zed/keymap.json"
    ];
    mode = "eager";
    copilot = {
      enterprise_uri = null;
      proxy = null;
      proxy_no_verify = null;
      enable_next_edit_suggestions = true;
    };
  };

  # ── Status bar ───────────────────────────────────────────────────────────
  status_bar = {
    "experimental.show" = true;
    active_language_button = true;
    cursor_position_button = true;
    line_endings_button = true;
  };

  # ── Integrated terminal ──────────────────────────────────────────────────
  terminal = {
    blinking = "on";
    cursor_shape = "bar";
    button = false;
    line_height = "comfortable";
    # Auto-activate Python virtual environments found in common directories.
    detect_venv = {
      on = {
        directories = [
          ".env"
          "env"
          ".venv"
          "venv"
        ];
        activate_script = "default";
        conda_manager = "auto";
      };
    };
  };

  # ── Completions ──────────────────────────────────────────────────────────
  completions = {
    words_min_length = 1;
  };

  languages = import ./languages.nix;
  lsp = import ./lsp.nix;

  # ── DAP (debug adapter) ──────────────────────────────────────────────────
  dap = {
    CodeLLDB = {
      env = {
        RUST_LOG = "info";
      };
    };
  };
}
