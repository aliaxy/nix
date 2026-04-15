{
  description = "aliaxy nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
      catppuccin,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          system.primaryUser = "aliaxy";
          nixpkgs.config.allowUnfree = true;

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            neovim
            mas
            keka
            ghostty-bin
            nixd
            nil
            uv
            rustup
            fnm
          ];

          homebrew = {
            enable = true;
            enableFishIntegration = true;
            onActivation = {
              autoUpdate = false;
              upgrade = false;
              cleanup = "zap";
            };
            greedyCasks = true;

            taps = [
              "nikitabobko/tap"
            ];

            brews = [
            ];

            casks = [
              "aerospace"
              "orbstack"
              "qq"
              "wechat"
              "wechatwork"
              "google-chrome"
              "zed"
              "notion"
              "typora"
              "sublime-text"
              "clash-verge-rev"
              "app-cleaner"
              "feishu"
              "sf-symbols"
              "font-sf-pro"
              "font-sf-mono"
              "microsoft-word"
              "microsoft-excel"
              "microsoft-powerpoint"
            ];

            masApps = {
              "Numbers" = 361304891;
            };
          };

          environment.shells = [
            pkgs.fish
          ];

          fonts.packages = [
            pkgs.nerd-fonts.jetbrains-mono
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          programs.fish.enable = true;

          users.users."aliaxy" = {
            home = "/Users/aliaxy";
            shell = pkgs.fish;
          };

          system.activationScripts.setDefaultShell.text = ''
            fish=/run/current-system/sw/bin/fish
            current=$(dscl . -read /Users/aliaxy UserShell 2>/dev/null | awk '{print $2}')
            if [ "$current" != "$fish" ]; then
              echo "Setting default shell for aliaxy to fish"
              dscl . -create /Users/aliaxy UserShell "$fish"
            fi
          '';

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          system.defaults = {
            finder = {
              AppleShowAllExtensions = true;
              FXPreferredViewStyle = "clmv";
            };
            dock = {
              autohide = true;

              persistent-apps = [
                "/System/Applications/System Settings.app"
                "/System/Applications/Messages.app"
                "/System/Applications/Mail.app"
                "/System/Applications/Reminders.app"
                "/System/Applications/iPhone Mirroring.app"
                "/Applications/Nix Apps/Ghostty.app"
                "/Applications/Google Chrome.app"
                "/Applications/Notion.app"
                "/Applications/Sublime Text.app"
                "/Applications/Zed.app"
                "/Applications/Orbstack.app"
                "/Applications/App Cleaner 9.app"
              ];
            };
          };
        };
      mirrors = {
        RUSTUP_DIST_SERVER = "https://rsproxy.cn";
        RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup";

        GOPROXY = "https://goproxy.cn,direct";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#air
      darwinConfigurations."air" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          {
            environment.variables = mirrors;
          }

          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "aliaxy";

              autoMigrate = true;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.aliaxy =
              { lib, ... }:
              let
                cfg = {
                  enable = true;
                  flavor = "macchiato";
                };
              in
              {
                imports = [
                  catppuccin.homeModules.catppuccin
                ];
                home.stateVersion = "25.11";

                catppuccin = {
                  bat = cfg;
                  ghostty = cfg;
                  starship = cfg;
                  eza = cfg // {
                    accent = "lavender";
                  };
                };

                home.sessionVariables = {
                  EZA_CONFIG_DIR = "$HOME/.config/eza";
                };

                home.file.".hushlogin".text = "";
                home.file.".cargo/config.toml".text = ''
                  [source.crates-io]
                  replace-with = 'rsproxy-sparse'
                  [source.rsproxy]
                  registry = "https://rsproxy.cn/crates.io-index"
                  [source.rsproxy-sparse]
                  registry = "sparse+https://rsproxy.cn/index/"
                  [registries.rsproxy]
                  index = "https://rsproxy.cn/crates.io-index"
                  [net]
                  git-fetch-with-cli = true
                '';
                home.file.".config/uv/uv.toml".text = ''
                  [[index]]
                  url = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple/"
                  default = true
                '';

                programs = {
                  git = {
                    enable = true;
                    settings.user.name = "aliaxy";
                    settings.user.email = "aruvelut00@163.com";
                    settings.init.defaultBranch = "main";
                  };

                  zoxide = {
                    enable = true;
                    enableFishIntegration = true;
                    options = [
                      "--cmd cd"
                    ];
                  };

                  go = {
                    enable = true;
                    env = {
                      GOPATH = "/Users/aliaxy/go";
                      GOBIN = "/Users/aliaxy/go/bin";
                    };
                  };

                  fish = {
                    enable = true;
                    interactiveShellInit = ''
                      set fish_greeting # Disable greeting
                      fnm env --use-on-cd --shell fish | source
                    '';

                    # shellAbbrs = {
                    shellAliases = {
                      ls = "eza";
                      la = "ls -a";
                      ll = "ls -lh";
                      lla = "ll -a";
                      lg = "lla --git";
                      tree = "ls -T";
                      rmi = "rm -i";
                      y = "yazi";
                      vi = "nvim";
                      vim = "nvim";
                      cat = "bat";
                      jy = "fastfetch";
                    };
                  };

                  starship = {
                    enable = true;
                    enableFishIntegration = true;
                    settings = {
                      add_newline = false;

                      scan_timeout = 5000;
                      command_timeout = 5000;

                      right_format = lib.concatStrings [
                        "$time"
                      ];

                      time = {
                        disabled = true;
                        format = "at [$time]($style)";
                        use_12hr = true;
                        time_format = "%Y-%m-%d %I:%M %p";
                      };
                      character = {
                        success_symbol = "[[󰋑](green) ❯](maroon)";
                        error_symbol = "[[󰋔](red) ❯](maroon)";
                        vimcmd_symbol = "[❮](green)";
                      };
                      directory = {
                        truncation_length = 4;
                        style = "bold lavender";
                      };

                    };
                  };

                  eza = {
                    enable = true;
                    enableFishIntegration = true;
                    colors = "always";
                    icons = "always";
                    extraOptions = [
                      "--time-style"
                      "+%Y-%m-%d %H:%M:%S"
                      "--header"
                      "--group-directories-first"
                    ];
                  };

                  fastfetch = {
                    enable = true;
                    settings = { };
                  };

                  bat = {
                    enable = true;
                  };

                  zed-editor = {
                    enable = true;
                    package = null;

                    extensions = [
                      "nix"
                      "toml"
                      "html"
                      "catppuccin"
                      "catppuccin-icons"
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

                      # AI Agent 配置 (2026 版：GPT-5.4 支持)
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

                      # 格式化与 LSP
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

                      # 编辑预测 (Inline Completion)
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
                      # proxy = "socks5://127.0.0.1:6153";
                      language_models = {
                        anthropic = {
                          api_url = "https://api.anthropic.com";
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
                        zed.dev = { };
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

                  ghostty = {
                    enable = true;
                    enableFishIntegration = true;
                    package = null;
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
                      window-padding-x = 5;
                      window-padding-y = 5;
                      window-padding-balance = true;
                      window-step-resize = true;
                      window-save-state = "default";
                      macos-icon = "official";
                      macos-titlebar-style = "tabs";
                      window-colorspace = "display-p3";
                      window-padding-color = "extend";
                    };
                  };

                  aerospace = {
                    enable = true;
                    launchd.enable = false;
                    package = null;
                    settings = {
                      config-version = 2;

                      after-login-command = [ ];
                      after-startup-command = [ ];
                      start-at-login = false;

                      enable-normalization-flatten-containers = true;
                      enable-normalization-opposite-orientation-for-nested-containers = true;

                      accordion-padding = 30;
                      default-root-container-layout = "tiles";
                      default-root-container-orientation = "auto";

                      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
                      automatically-unhide-macos-hidden-apps = false;
                      persistent-workspaces = [
                        "1"
                        "2"
                        "3"
                        "4"
                        "5"
                        "6"
                        "7"
                        "8"
                        "9"
                        "A"
                      ];

                      on-mode-changed = [ ];

                      key-mapping.preset = "qwerty";

                      gaps = {
                        inner.horizontal = 10;
                        inner.vertical = 10;
                        outer.left = 8;
                        outer.bottom = 8;
                        outer.top = 12;
                        outer.right = 8;
                      };

                      mode.main.binding = {
                        alt-slash = "layout tiles horizontal vertical";
                        alt-comma = "layout accordion horizontal vertical";

                        alt-h = "focus left";
                        alt-j = "focus down";
                        alt-k = "focus up";
                        alt-l = "focus right";

                        alt-shift-h = "move left";
                        alt-shift-j = "move down";
                        alt-shift-k = "move up";
                        alt-shift-l = "move right";

                        alt-shift-minus = "resize smart -50";
                        alt-shift-equal = "resize smart +50";

                        alt-1 = "workspace 1";
                        alt-2 = "workspace 2";
                        alt-3 = "workspace 3";
                        alt-4 = "workspace 4";
                        alt-5 = "workspace 5";
                        alt-6 = "workspace 6";
                        alt-7 = "workspace 7";
                        alt-8 = "workspace 8";
                        alt-9 = "workspace 9";

                        # Uncomment this if need more workspace
                        # alt-a = "workspace A";
                        # alt-b = "workspace B";
                        # alt-c = "workspace C";
                        # alt-d = "workspace D";
                        # alt-e = "workspace E";
                        # alt-f = "workspace F";
                        # alt-g = "workspace G";
                        # alt-i = "workspace I";
                        # alt-m = "workspace M";
                        # alt-n = "workspace N";
                        # alt-o = "workspace O";
                        # alt-p = "workspace P";
                        # alt-q = "workspace Q";
                        # alt-r = "workspace R";
                        # alt-s = "workspace S";
                        # alt-t = "workspace T";
                        # alt-u = "workspace U";
                        # alt-v = "workspace V";
                        # alt-w = "workspace W";
                        # alt-x = "workspace X";
                        # alt-y = "workspace Y";
                        # alt-z = "workspace Z";

                        alt-shift-1 = "move-node-to-workspace 1";
                        alt-shift-2 = "move-node-to-workspace 2";
                        alt-shift-3 = "move-node-to-workspace 3";
                        alt-shift-4 = "move-node-to-workspace 4";
                        alt-shift-5 = "move-node-to-workspace 5";
                        alt-shift-6 = "move-node-to-workspace 6";
                        alt-shift-7 = "move-node-to-workspace 7";
                        alt-shift-8 = "move-node-to-workspace 8";
                        alt-shift-9 = "move-node-to-workspace 9";

                        # Uncomment this if need more workspace

                        # alt-shift-a = "move-node-to-workspace A";
                        # alt-shift-b = "move-node-to-workspace B";
                        # alt-shift-c = "move-node-to-workspace C";
                        # alt-shift-d = "move-node-to-workspace D";
                        # alt-shift-e = "move-node-to-workspace E";
                        alt-shift-f = "fullscreen";
                        # alt-shift-g = "move-node-to-workspace G";
                        # alt-shift-i = "move-node-to-workspace I";
                        # alt-shift-m = "move-node-to-workspace M";
                        # alt-shift-n = "move-node-to-workspace N";
                        # alt-shift-o = "move-node-to-workspace O";
                        # alt-shift-p = "move-node-to-workspace P";
                        # alt-shift-q = "move-node-to-workspace Q";
                        # alt-shift-r = "move-node-to-workspace R";
                        # alt-shift-s = "move-node-to-workspace S";
                        # alt-shift-t = "move-node-to-workspace T";
                        # alt-shift-u = "move-node-to-workspace U";
                        # alt-shift-v = "move-node-to-workspace V";
                        # alt-shift-w = "move-node-to-workspace W";
                        # alt-shift-x = "move-node-to-workspace X";
                        # alt-shift-y = "move-node-to-workspace Y";
                        # alt-shift-z = "move-node-to-workspace Z";

                        alt-tab = "workspace-back-and-forth";
                        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

                        alt-shift-semicolon = "mode service";

                        # alt-enter = 'exec-and-forget /Applications/Ghostty.app/Contents/MacOS/ghostty'
                        # alt-shift-enter = 'exec-and-forget /Applications/Ghostty.app/Contents/MacOS/ghostty --title="floating-terminal"'

                        # alt-e = 'exec-and-forget open -a finder'

                        # # Disable "hide application" and "hide others"
                        # cmd-h = []
                        # cmd-alt-h = []

                        # # Toggle between floating and tiling layout
                        # alt-backslash = 'layout floating tiling'

                        # alt-f = 'fullscreen'

                        # alt-r = 'mode resize'
                      };

                      mode.service.binding = {
                        esc = [
                          "reload-config"
                          "mode main"
                        ];
                        r = [
                          "flatten-workspace-tree"
                          "mode main"
                        ];
                        f = [
                          "layout floating tiling"
                          "mode main"
                        ];
                        backspace = [
                          "close-all-windows-but-current"
                          "mode main"
                        ];

                        alt-shift-h = [
                          "join-with left"
                          "mode main"
                        ];
                        alt-shift-j = [
                          "join-with down"
                          "mode main"
                        ];
                        alt-shift-k = [
                          "join-with up"
                          "mode main"
                        ];
                        alt-shift-l = [
                          "join-with right"
                          "mode main"
                        ];
                      };

                      # [mode.resize.binding]
                      #     h = 'resize width -50'
                      #     j = 'resize height +50'
                      #     k = 'resize height -50'
                      #     l = 'resize width +50'

                      #     enter = 'mode main'
                      #     esc = 'mode main'

                      on-window-detected = [
                        {
                          "if".app-id = "com.apple.finder";
                          run = [ "layout floating" ];
                        }
                        {
                          "if".app-id = "com.tencent.qq";
                          run = [ "layout floating" ];
                        }
                        {
                          "if".app-id = "com.tencent.xinWeChat";
                          run = [ "layout floating" ];
                        }
                      ];
                    };
                  };
                };

                services.jankyborders = {
                  enable = true;
                  settings = {
                    style = "round";
                    width = 6.0;
                    blur_radius = 0.0;
                    active_color = "0xffb7bdf8";
                    inactive_color = "0xff6e738d";
                    background_color = "0x00000000";
                  };
                };
              };
          }
        ];
      };
    };
}
