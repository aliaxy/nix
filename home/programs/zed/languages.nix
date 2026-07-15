{
  C = {
    use_on_type_format = false;
    prettier = {
      allowed = false;
    };
  };

  "C++" = {
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
    # Enforce the 72-character subject-line convention.
    allow_rewrap = "anywhere";
    soft_wrap = "editor_width";
    preferred_line_length = 72;
  };

  Go = {
    hard_tabs = true; # gofmt requires tabs
    code_actions_on_format = {
      "source.organizeImports" = true;
    };
    language_servers = [
      "gopls"
      "golangci-lint"
    ];
  };

  JavaScript = {
    # Prefer vtsls over the default typescript-language-server.
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
      "!pyright"
      "!pylsp"
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

  Swift = {
    enable_language_server = true;
    language_servers = ["sourcekit-lsp"];
    formatter = "language_server";
    format_on_save = "on";
  };

  Nix = {
    formatter = {
      external = {
        command = "alejandra";
        arguments = [
          "--quiet"
          "--"
        ];
      };
    };
  };
}
