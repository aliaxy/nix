# Per-language overrides, file type mappings, Prettier, and debuggers.
#
# language_servers merge semantics:
#   "..."   expands the remaining default servers here
#   "!name" disables a server
#   a list without "..." replaces the default set entirely
{
  # ── Per-language settings ────────────────────────────────────────────────
  languages = {
    Astro = {
      format_on_save = "on";
      language_servers = [
        "astro-language-server"
        "..."
      ];
      prettier = {
        allowed = true;
        plugins = [
          "prettier-plugin-astro"
        ];
      };
    };

    Blade = {
      prettier = {
        allowed = true;
      };
    };

    C = {
      language_servers = ["!sourcekit-lsp" "..."];
      use_on_type_format = false;
      prettier = {
        allowed = false;
      };
      debuggers = ["CodeLLDB"];
    };

    "C++" = {
      language_servers = ["!sourcekit-lsp" "..."];
      use_on_type_format = false;
      prettier = {
        allowed = false;
      };
      debuggers = ["CodeLLDB"];
    };

    CSharp = {
      language_servers = [
        "roslyn"
        "!csharp-ls"
        "!omnisharp"
        "..."
      ];
    };

    CSS = {
      language_servers = [
        "tailwindcss-intellisense-css"
        "!vscode-css-language-server"
        "!tailwindcss-language-server"
        "..."
      ];

      prettier = {
        allowed = false;
      };
    };

    Dart = {
      code_actions_on_format = {
        "source.organizeImports" = true;
        "source.fixAll" = true;
      };

      debuggers = ["Dart"];
    };

    Diff = {
      show_edit_predictions = false;
      remove_trailing_whitespace_on_save = false;
      ensure_final_newline_on_save = false;
    };

    Dockerfile = {
      language_servers = ["!docker-language-server" "..."];

      debuggers = ["buildx-dockerfile"];
    };

    EEx = {
      format_on_save = "on";
      language_servers = [
        "elixir-ls"
        "!expert"
        "!dexter"
        "!next-ls"
        "!lexical"
        "..."
      ];
    };

    Elixir = {
      format_on_save = "on";
      language_servers = [
        "elixir-ls"
        "!expert"
        "!dexter"
        "!next-ls"
        "!lexical"
        "!emmet-language-server"
        "..."
      ];
    };

    Elm = {
      format_on_save = "on";
      tab_size = 4;
    };

    Erlang = {
      language_servers = [
        "erlang-ls"
        "!elp"
        "..."
      ];
    };

    Fish = {
      formatter = {
        external = {
          command = "fish_indent";
        };
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
      language_servers = [
        "gopls"
        "golangci-lint"
      ];
      debuggers = ["Delve"];
    };

    GraphQL = {
      prettier = {
        allowed = true;
      };
    };

    HEEx = {
      format_on_save = "on";
      language_servers = [
        "elixir-ls"
        "!expert"
        "!dexter"
        "!next-ls"
        "!lexical"
        "..."
      ];
    };

    HTML = {
      prettier = {
        allowed = true;
      };
    };

    "HTML+ERB" = {
      language_servers = [
        "herb"
        "!ruby-lsp"
        "..."
      ];
    };

    Java = {
      tab_size = 4;
      code_actions_on_format = {
        "source.organizeImports" = true;
      };
      prettier = {
        allowed = false;
        plugins = [
          "prettier-plugin-java"
        ];
      };
      debuggers = ["Java"];
    };

    JavaScript = {
      language_servers = [
        "!typescript-language-server"
        "vtsls"
        "biome"
        "..."
      ];
      formatter = {
        language_server = {
          name = "biome";
        };
      };
      code_actions_on_format = {
        "source.fixAll.biome" = true;
        "source.organizeImports.biome" = true;
      };
      prettier = {
        allowed = false;
      };
    };

    JSON = {
      prettier = {
        allowed = true;
      };
    };

    JSONC = {
      prettier = {
        allowed = true;
      };
    };

    "JS+ERB" = {
      language_servers = [
        "!ruby-lsp"
        "..."
      ];
    };

    Kotlin = {
      format_on_save = "on";
      language_servers = [
        "!kotlin-language-server"
        "kotlin-lsp"
        "..."
      ];
    };

    LaTeX = {
      formatter = "language_server";
      language_servers = [
        "texlab"
        "..."
      ];
      prettier = {
        allowed = true;
        plugins = [
          "prettier-plugin-latex"
        ];
      };
    };

    Markdown = {
      use_on_type_format = false;
      remove_trailing_whitespace_on_save = false;
      allow_rewrap = "anywhere";
      soft_wrap = "editor_width";
      completions = {
        words = "disabled";
      };
      prettier = {
        allowed = false;
      };
    };

    Nginx = {
      formatter = {
        external = {
          command = "nginxfmt";
          arguments = ["-"];
        };
      };
    };

    Nix = {
      language_servers = ["!nil" "..."];
      formatter = {
        external = {
          command = "alejandra";
          arguments = ["--quiet" "--"];
        };
      };
    };

    PHP = {
      language_servers = [
        "phpactor"
        "!intelephense"
        "!phptools"
        "!phpantom"
        "..."
      ];
      prettier = {
        allowed = true;
        plugins = ["@prettier/plugin-php"];
        parser = "php";
      };
    };

    "Plain Text" = {
      allow_rewrap = "anywhere";
      soft_wrap = "editor_width";
      completions = {
        words = "disabled";
      };
    };

    Proto = {
      language_servers = [
        "buf"
        "!protols"
        "!protobuf-language-server"
        "..."
      ];
    };

    Python = {
      # Global tab_size is 2.
      tab_size = 4;
      code_actions_on_format = {
        "source.organizeImports.ruff" = true;
      };
      formatter = {
        language_server = {
          name = "ruff";
        };
      };
      debuggers = ["Debugpy"];
      language_servers = [
        "!basedpyright"
        "!pyright"
        "!pylsp"
        "ruff"
        "ty"
        "..."
      ];
    };

    "Rainbow TSV (⭲)" = {
      remove_trailing_whitespace_on_save = false;
      show_whitespaces = "all";
    };

    Ruby = {
      language_servers = [
        "solargraph"
        "!ruby-lsp"
        "!rubocop"
        "!sorbet"
        "!steep"
        "!kanayago"
        "!fuzzy-ruby-server"
        "..."
      ];
    };

    Rust = {
      # Global tab_size is 2.
      tab_size = 4;
      format_on_save = "on";
      debuggers = ["CodeLLDB"];
    };

    SCSS = {
      prettier = {
        allowed = true;
      };
    };

    Starlark = {
      format_on_save = "on";
      language_servers = [
        "starpls"
        "!buck2-lsp"
        "!tilt"
        "..."
      ];
    };

    Svelte = {
      language_servers = [
        "svelte-language-server"
        "..."
      ];
      prettier = {
        allowed = true;
        plugins = [
          "prettier-plugin-svelte"
        ];
      };
    };

    # Not part of Zed's default schema.
    Swift = {
      enable_language_server = true;
      language_servers = [
        "sourcekit-lsp"
      ];
      formatter = "language_server";
      format_on_save = "on";
    };

    SystemVerilog = {
      language_servers = [
        "!slang"
        "..."
      ];
      use_on_type_format = false;
    };

    TSX = {
      language_servers = [
        "!typescript-language-server"
        "vtsls"
        "..."
      ];
      prettier = {
        allowed = true;
      };
    };

    Twig = {
      prettier = {
        allowed = true;
      };
    };

    TypeScript = {
      language_servers = [
        "!typescript-language-server"
        "vtsls"
        "biome"
        "..."
      ];
      formatter = {
        language_server = {
          name = "biome";
        };
      };
      code_actions_on_format = {
        "source.fixAll.biome" = true;
        "source.organizeImports.biome" = true;
      };
      prettier = {
        allowed = false;
      };
    };

    "Vue.js" = {
      language_servers = [
        "!vue-language-server"
        "!vtsls"
        "biome"
        "..."
      ];
      prettier = {
        allowed = true;
      };
    };

    XML = {
      prettier = {
        allowed = true;
        plugins = [
          "@prettier/plugin-xml"
        ];
      };
    };

    YAML = {
      prettier = {
        allowed = true;
      };
    };

    Zig = {
      format_on_save = "on";
      language_servers = [
        "zls"
        "..."
      ];
    };
  };

  # ── File type mappings ───────────────────────────────────────────────────
  # Language name to a list of filename or extension globs.
  file_types = {
    JSONC = [
      "**/.zed/*.json"
      "**/.vscode/**/*.json"
      "**/{zed,Zed}/{settings,keymap,tasks,debug}.json"
      "tsconfig*.json"
    ];
    Markdown = [".rules" ".cursorrules" ".windsurfrules" ".clinerules"];
    "Shell Script" = [".env.*"];
  };

  # ── Prettier ─────────────────────────────────────────────────────────────
  # A project's own package.json Prettier config overrides these defaults.
  prettier = {
    allowed = false;
    plugins = [];
    # A non-empty string forces the parser.
    parser = "";
    # Other keys follow the package.json prettier section, e.g.
    # trailingComma = "es5"; tabWidth = 4; semi = false; singleQuote = true;
  };

  jsx_tag_auto_close = {
    enabled = true;
  };

  # Usually configured per language in languages.<lang>.debuggers.
  debuggers = [];
}
