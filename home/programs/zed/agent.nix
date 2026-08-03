# AI: agent panel and tool permissions, edit predictions, model providers, MCP.
{
  disable_ai = false;

  # ── Agent panel ──────────────────────────────────────────────────────────
  agent = {
    enabled = true;
    button = true;

    # "left" | "right" | "bottom"
    dock = "right";
    flexible = true;
    default_width = 640; # left/right dock
    default_height = 320; # bottom dock

    # "left" | "right"
    sidebar_side = "left";

    limit_content_width = true;
    max_content_width = 850;

    # ── Model ──────────────────────────────────────────────────────────────
    default_model = {
      provider = "zed.dev";
      model = "claude-sonnet-5";
      enable_thinking = true;
      # Not present in Zed's default schema; may be silently ignored.
      effort = "high";
    };

    # Also absent from the default schema.
    favorite_models = [];

    # The last entry matching provider and model wins; both fields are
    # optional, e.g. { provider = "openai"; temperature = 0.5; }
    model_parameters = [];

    # ── Tool permissions ───────────────────────────────────────────────────
    # Per-tool regexes match the tool input text (commands, paths, URLs);
    # copy_path and move_path match source and destination independently.
    # deny and confirm still win over an external agent's own permissions.
    tool_permissions = {
      # "allow" | "deny" | "confirm"
      default = "confirm";
      # Each tool takes its own default plus regex lists; the per-tool
      # default also applies to MCP tools.
      tools = {
        # terminal = {
        #   default = "confirm";
        #   always_confirm = [
        #     { pattern = "git\\s+(reset|clean)\\s+--hard"; }
        #     { pattern = "git\\s+push\\s+(-f|--force)"; }
        #   ];
        # };
        # edit_file = {
        #   default = "confirm";
        #   always_deny = [
        #     { pattern = "\\.env($|\\.)"; }
        #     { pattern = "secrets?/"; }
        #     { pattern = "\\.pem$"; }
        #   ];
        # };
      };
    };

    # ── Tool profiles ──────────────────────────────────────────────────────
    default_profile = "write";

    profiles = {
      write = {
        name = "Write";
        enable_all_context_servers = true;
        tools = {
          copy_path = true;
          create_directory = true;
          create_thread = true;
          delete_path = true;
          diagnostics = true;
          apply_code_action = true;
          edit_file = true;
          write_file = true;
          fetch = true;
          find_path = true;
          find_references = true;
          get_code_actions = true;
          go_to_definition = true;
          list_agents_and_models = true;
          list_directory = true;
          move_path = true;
          rename_symbol = true;
          read_file = true;
          grep = true;
          skill = true;
          spawn_agent = true;
          terminal = true;
          search_web = true;
        };
      };

      ask = {
        name = "Ask";
        # Left off upstream: MCP tools cannot be assumed read-only.
        # enable_all_context_servers = true;
        tools = {
          create_thread = true;
          diagnostics = true;
          fetch = true;
          list_agents_and_models = true;
          list_directory = true;
          find_path = true;
          find_references = true;
          get_code_actions = true;
          go_to_definition = true;
          read_file = true;
          grep = true;
          skill = true;
          spawn_agent = true;
          search_web = true;
        };
      };

      minimal = {
        name = "Minimal";
        enable_all_context_servers = false;
        tools = {};
      };
    };

    # ── Context compaction ─────────────────────────────────────────────────
    auto_compact = {
      enabled = true;
      # Percentage string of the context window, a positive integer of tokens
      # used, or a negative integer of tokens remaining. 0 is invalid.
      threshold = "90%";
    };

    # ── Interaction ────────────────────────────────────────────────────────
    # "primary_screen" | "all_screens" | "never"
    notify_when_agent_waiting = "primary_screen";
    # "never" | "when_hidden" | "always"
    play_sound_when_agent_done = "never";

    expand_edit_card = true;
    expand_terminal_card = true;
    # "auto"
    thinking_display = "auto";
    show_turn_stats = false;

    single_file_review = false;
    enable_feedback = true;
    show_merge_conflict_indicator = true;

    # true sends with cmd-enter (ctrl-enter on Linux/Windows).
    use_modifier_to_send = false;
    message_editor_min_lines = 4;

    # Applies to the stop button only, not ctrl-c inside the terminal.
    cancel_generation_on_terminal_stop = true;

    # Sent to the shell when a terminal thread opens, e.g. "claude".
    # "" disables it.
    terminal_init_command = "";

    # ── Misc ───────────────────────────────────────────────────────────────
    inline_assistant_use_streaming_tools = true;
    # Includes AGENTS.md / CLAUDE.md / .rules when generating commit messages.
    commit_message_include_project_rules = true;
  };

  # ── Edit predictions ─────────────────────────────────────────────────────
  # false requires editor::ShowEditPrediction to trigger them manually.
  show_edit_predictions = true;

  # Syntax scopes to suppress predictions in, e.g. ["string" "comment"].
  edit_predictions_disabled_in = [];

  edit_predictions = {
    provider = "zed";

    # Appended to the built-in list. Matched against the worktree root unless
    # the glob starts with "/".
    disabled_globs = [
      "**/*.env"
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

    # "eager" | "subtle"
    mode = "eager";

    copilot = {
      enterprise_uri = null;
      proxy = null;
      proxy_no_verify = null;
      enable_next_edit_suggestions = true;
    };

    codestral = {
      api_url = "https://codestral.mistral.ai";
      model = "codestral-latest";
      max_tokens = 150;
    };

    ollama = {
      api_url = "http://localhost:11434";
      model = "qwen2.5-coder:7b-base";
      prompt_format = "infer";
      max_output_tokens = 64;
    };

    open_ai_compatible_api = {
      api_url = "";
      model = "";
      prompt_format = "infer";
      max_output_tokens = 64;
    };

    # Only ever collects from projects detected as open source.
    # "default" | "yes" | "no"
    allow_data_collection = "no";
  };

  # ── Model provider endpoints ─────────────────────────────────────────────
  language_models = {
    anthropic = {
      api_url = "https://api.anthropic.com";
    };
    anthropic_compatible = {};
    bedrock = {};
    google = {
      api_url = "https://generativelanguage.googleapis.com";
    };
    ollama = {
      api_url = "http://localhost:11434";
    };
    "llama.cpp" = {
      api_url = "http://localhost:8080";
    };
    openai = {
      api_url = "https://api.openai.com/v1";
    };
    openai_compatible = {};
    opencode = {
      api_url = "https://opencode.ai/zen";
    };
    open_router = {
      api_url = "https://openrouter.ai/api/v1";
    };
    lmstudio = {
      api_url = "http://localhost:1234/api/v0";
    };
    deepseek = {
      api_url = "https://api.deepseek.com/v1";
    };
    mistral = {
      api_url = "https://api.mistral.ai/v1";
    };
    vercel_ai_gateway = {
      api_url = "https://ai-gateway.vercel.sh/v1";
    };
    x_ai = {
      api_url = "https://api.x.ai/v1";
    };
    "zed.dev" = {};
  };

  # ── MCP and external agents ──────────────────────────────────────────────
  # Default per-call timeout in seconds; individual servers may override it.
  context_server_timeout = 60;

  # e.g. my-stdio-server = { command = "/path/to/server"; timeout = 120; };
  # Merged with programs.zed-editor.enableMcpIntegration.
  context_servers = {};

  agent_servers = {};
}
