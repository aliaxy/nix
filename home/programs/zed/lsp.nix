# Language intelligence: servers, semantic highlighting, inlay hints,
# navigation, and per-server configuration.
{
  # ── Language server toggles ──────────────────────────────────────────────
  enable_language_server = true;

  # "..." expands the remaining defaults, "!name" disables a server.
  # Usually configured per language in languages.<lang>.language_servers.
  language_servers = ["..."];

  linked_edits = true;
  use_on_type_format = true;

  # ── Semantic highlighting and document structure ─────────────────────────
  # "off" | "combined" | "full"; may need a server restart to take effect.
  semantic_tokens = "combined";

  # "off" (tree-sitter + indent) | "on" (LSP first, falls back)
  document_folding_ranges = "off";

  # "off" (tree-sitter queries) | "on" (LSP textDocument/documentSymbol)
  document_symbols = "off";

  # ── Inlay hints ──────────────────────────────────────────────────────────
  inlay_hints = {
    enabled = true;
    show_type_hints = true;
    show_parameter_hints = true;
    show_value_hints = true;
    # Hints whose LSP kind is null/None.
    show_other_hints = true;
    show_background = false;
    # 0 disables debouncing.
    edit_debounce_ms = 300;
    scroll_debounce_ms = 50;
    # Hints toggle only while all enabled modifiers are held.
    toggle_on_modifiers_press = {
      control = false;
      shift = false;
      alt = false;
      platform = false;
      function = false;
    };
  };

  # ── Code lens and code actions ───────────────────────────────────────────
  # "off" | "on" | "menu"
  code_lens = "on";

  inline_code_actions = true;

  code_actions_on_format = {};

  # ── Navigation ───────────────────────────────────────────────────────────
  # "find_all_references" | "none"
  go_to_definition_fallback = "find_all_references";

  # "center" | "minimum" | "top" | "preserve"
  go_to_definition_scroll_strategy = "center";

  # "multi_buffer" | "picker"; a single result always opens directly.
  lsp_results_location = "picker";

  lsp_highlight_debounce = 75;

  # ── Document decorations ─────────────────────────────────────────────────
  # textDocument/documentColor: "none" | "inlay" | "border" | "background"
  lsp_document_colors = "inlay";

  lsp_document_links = true;

  # ── Signature help ───────────────────────────────────────────────────────
  auto_signature_help = false;
  # Treated as true when auto_signature_help is enabled.
  show_signature_help_after_edits = true;

  # ── Shared language server settings ──────────────────────────────────────
  global_lsp_settings = {
    button = true;
    # Seconds; 0 disables the timeout.
    request_timeout = 120;
    # Longer lines disable language server features for the whole buffer.
    max_buffer_line_length = 20000;
    notifications = {
      # 0 disables auto-dismiss.
      dismiss_timeout_ms = 5000;
    };
    # User rules are prepended to the defaults, so they win. Each rule takes
    # token_type / token_modifiers / style / foreground_color /
    # background_color / underline / strikethrough / font_weight / font_style.
    # Run "zed: show default semantic token rules" to see the defaults.
    semantic_token_rules = [];
  };

  # ── Per-server configuration ─────────────────────────────────────────────
  lsp = {
    clangd = {
      # Arguments for the clangd process itself; Zed passes none by default.
      binary.arguments = [
        # Complete symbols from scopes not visible at the cursor, inserting
        # the qualification.
        "--all-scopes-completion"
        # Persist a project index on disk for cross-file navigation.
        "--background-index"
        # clang-tidy runs inside clangd. Check selection is only possible
        # through a project .clang-tidy file; without one the default set is
        # clang-diagnostic-* plus clang-analyzer-*.
        "--clang-tidy"
      ];

      initialization_options = {
        # Compiler flags used only when no compile_commands.json is found, so
        # projects with a build system are unaffected. No -std here: clangd
        # shares one config across C and C++, and a C++ standard is a driver
        # error on .c files. These three are valid for both languages.
        fallbackFlags = [
          "-Wall"
          "-Wextra"
          "-Wshadow"
        ];
      };
    };

    gopls = {
      initialization_options = {
        gofumpt = true;
      };
    };

    golangci-lint = {
      initialization_options = {
        # Requires golangci-lint v2 flag syntax.
        command = [
          "golangci-lint"
          "run"
          "--enable"
          "revive"
          "--output.json.path"
          "stdout"
          "--show-stats=false"
          "--output.text.path="
        ];
      };
    };

    jdtls = {
      settings = {
        lombok_support = true;
        jdk_auto_download = false;
        check_updates = "always";
      };
    };
  };
}
