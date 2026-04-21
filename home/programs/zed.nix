# Zed editor complete configuration
{ ... }:
{
  programs.zed-editor = {
    enable = true;
    package = null; # Managed by Homebrew cask

    extensions = [
      "nix"
      "toml"
      "html"
      "catppuccin"
      "catppuccin-icons"
      "lua"
    ];

    userSettings = {
      project_name = null;

      theme = {
        mode = "system";
        light = "Catppuccin Macchiato";
        dark = "Catppuccin Macchiato";
      };
      icon_theme = {
        mode = "system";
        light = "Catppuccin Macchiato";
        dark = "Zed (Default)";
      };

      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_fallbacks = [
        "JetBrainsMono Nerd Font"
        "PingFang SC"
        "Apple Symbols"
      ];
      buffer_font_size = 13;
      buffer_font_weight = 400;

      ui_font_family = ".SystemUIFont";
      ui_font_fallbacks = [
        "JetBrainsMono Nerd Font"
        "PingFang SC"
        "Apple Symbols"
      ];
      ui_font_weight = 500;
      ui_font_size = 13;

      active_pane_modifiers = {
        border_size = 0.8;
        inactive_opacity = 1.0;
      };

      use_system_path_prompts = true;
      use_system_prompts = true;
      current_line_highlight = "gutter";
      auto_signature_help = false;
      use_system_window_tabs = false;

      title_bar = {
        show_branch_icon = true;
        show_branch_name = true;
        show_project_items = true;
        show_onboarding_banner = true;
        show_user_picture = true;
        show_sign_in = true;
        show_menus = false;
      };

      scrollbar = {
        axes = {
          horizontal = false;
          vertical = true;
        };
      };

      gutter = {
        min_line_number_digits = 2;
      };

      indent_guides = {
        coloring = "indent_aware";
      };

      search = {
        button = true;
        whole_word = false;
        case_sensitive = false;
        include_ignored = false;
        regex = true;
        center_on_match = false;
      };

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

      collaboration_panel = {
        button = false;
        dock = "left";
        default_width = 240;
      };

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

      formatter = "language_server";
      tab_size = 2;

      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      auto_update = false;

      diagnostics = {
        inline = {
          enabled = true;
          update_debounce_ms = 150;
          padding = 2;
          min_column = 0;
          max_severity = null;
        };
      };

      edit_predictions = {
        provider = "zed";
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

      status_bar = {
        "experimental.show" = true;
        active_language_button = true;
        cursor_position_button = true;
        line_endings_button = true;
      };

      terminal = {
        blinking = "on";
        cursor_shape = "bar";
        button = false;
        line_height = "comfortable";
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

      completions = {
        words_min_length = 1;
      };

      languages = {
        C = {
          format_on_save = "on";
          use_on_type_format = false;
          prettier = {
            allowed = false;
          };
        };
        "C++" = {
          format_on_save = "on";
          use_on_type_format = false;
          prettier = {
            allowed = false;
          };
        };
        CSS = {
          prettier = {
            allowed = true;
          };
        };
        "Git Commit" = {
          allow_rewrap = "anywhere";
          soft_wrap = "editor_width";
          preferred_line_length = 72;
        };
        Go = {
          hard_tabs = true;
          code_actions_on_format = {
            "source.organizeImports" = true;
          };
          language_servers = [ "gopls" ];
        };
        JavaScript = {
          language_servers = [
            "!typescript-language-server"
            "vtsls"
            "..."
          ];
          prettier = {
            allowed = true;
          };
        };
        Python = {
          tab_size = 4;
          code_actions_on_format = {
            "source.organizeImports.ruff" = true;
          };
          formatter = {
            language_server = {
              name = "ruff";
            };
          };
          language_servers = [
            "!basedpyright"
            "ruff"
            "ty"
            "..."
          ];
        };
        Rust = {
          tab_size = 4;
        };
        "Vue.js" = {
          language_servers = [
            "vue-language-server"
            "vtsls"
            "..."
          ];
          prettier = {
            allowed = true;
          };
        };
        YAML = {
          prettier = {
            allowed = true;
          };
        };
      };

      language_models = {
        anthropic = {
          api_url = "https://api.aipaibox.com";
        };
        bedrock = { };
        deepseek = {
          api_url = "https://api.deepseek.com/v1";
        };
        google = {
          api_url = "https://generativelanguage.googleapis.com";
        };
        lmstudio = {
          api_url = "http://localhost:1234/api/v0";
        };
        mistral = {
          api_url = "https://api.mistral.ai/v1";
        };
        ollama = {
          api_url = "http://localhost:11434";
        };
        open_router = {
          api_url = "https://openrouter.ai/api/v1";
        };
        openai = {
          api_url = "https://api.openai.com/v1";
        };
        openai_compatible = { };
        opencode = {
          api_url = "https://opencode.ai/zen";
        };
        vercel = {
          api_url = "https://api.v0.dev/v1";
        };
        vercel_ai_gateway = {
          api_url = "https://ai-gateway.vercel.sh/v1";
        };
        x_ai = {
          api_url = "https://api.x.ai/v1";
        };
        "zed.dev" = { };
      };

      lsp = {
        clangd = {
          initialization_options = {
            fallbackFlags = [ "-std=c++23" ];
          };
        };
      };

      dap = {
        CodeLLDB = {
          env = {
            RUST_LOG = "info";
          };
        };
      };
    };
  };
}
