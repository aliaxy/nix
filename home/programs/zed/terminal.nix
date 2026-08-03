# Integrated terminal.
{
  terminal = {
    # ── Shell and working directory ────────────────────────────────────────
    # "system" (reads /etc/passwd) | { program = "sh"; } |
    # { with_arguments = { program = "/bin/bash"; args = ["--login"]; }; }
    shell = "system";

    # "current_file_directory" | "current_project_directory" |
    # "first_project_directory" | "always_home" |
    # { always = { directory = "~/projects/"; }; }
    working_directory = "current_project_directory";

    # Extra environment variables; use ":" to separate multiple values.
    env = {};

    # ── Dock and size ──────────────────────────────────────────────────────
    # "left" | "right" | "bottom"
    dock = "bottom";
    flexible = true;
    default_width = 640;
    default_height = 320;
    button = false;

    toolbar = {
      # Requires the shell to emit a title escape sequence.
      breadcrumbs = false;
    };

    scrollbar = {
      # null inherits the editor setting.
      # "auto" | "system" | "always" | "never"
      show = null;
    };

    # ── Cursor ─────────────────────────────────────────────────────────────
    # "off" | "terminal_controlled" | "on"
    blinking = "on";
    # "block" | "bar" | "underline" | "hollow"
    cursor_shape = "bar";

    # ── Font and layout ────────────────────────────────────────────────────
    # font_size / font_family / font_fallbacks follow the buffer font
    # when omitted.
    font_weight = 400;

    # "comfortable" (1.618) | "standard" (1.3, better for TUIs and box
    # drawing) | { custom = 2; }
    line_height = "comfortable";

    # APCA perceptual contrast, 0–106. Most terminal themes sit at 40–70.
    minimum_contrast = 45;

    # ── Input and selection ────────────────────────────────────────────────
    # true makes option a meta key instead of composing special characters.
    option_as_meta = true;

    copy_on_select = false;
    keep_selection_on_copy = true;

    # Whether cmd-click still opens links while the program reports mouse
    # events; shift-cmd-click works either way.
    open_links_in_mouse_mode = true;

    # Turns the scroll wheel into arrow keys on the alternate screen.
    # "on" | "off"
    alternate_scroll = "on";

    scroll_multiplier = 1.0;

    # ── Scrollback ─────────────────────────────────────────────────────────
    # Max 100000; 0 disables scrolling. Existing terminals keep the old value.
    max_scroll_history_lines = 50000;

    # ── Python virtualenv ──────────────────────────────────────────────────
    # Set to "off" to disable auto-activation.
    detect_venv = {
      on = {
        directories = [".env" "env" ".venv" "venv"];
        # "default" | "csh" | "fish" | "nushell" | "power_shell"
        activate_script = "fish";
        # "auto" | "conda" | "mamba" | "micromamba"
        conda_manager = "auto";
      };
    };

    # ── Path hyperlinks ────────────────────────────────────────────────────
    # Named capture groups path / line / column / link. Without any of them
    # the whole match is the target. Matching stops at the first regex that
    # matches, so order by hit frequency. A list of strings is joined into one
    # multi-line regex.
    path_hyperlink_regexes = [
      # Python-style diagnostics
      "File \"(?<path>[^\"]+)\", line (?<line>[0-9]+)"
      # Common paths with optional line/column, punctuation and delimiters
      [
        "(?x)"
        "(?<path>"
        "    ("
        "        # multi-char path: first char (not opening delimiter, space, or box drawing char)"
        "        [^({\\[<\"'`\\ \\u2500-\\u257F]"
        "        # middle chars: non-space, and colon/paren only if not followed by digit/paren/space"
        "        ([^\\ :(]|[:(][^0-9()\\ ])*"
        "        # last char: not closing delimiter or colon"
        "        [^()}\\]>\"'`.,;:\\ ]"
        "    |"
        "        # single-char path: not delimiter, punctuation, space, or box drawing char"
        "        [^(){}\\[\\]<>\"'`.,;:\\ \\u2500-\\u257F]"
        "    )"
        "    # optional line/column suffix (included in path for PathWithPosition::parse_str)"
        "    (:+[0-9]+(:[0-9]+)?|:?\\([0-9]+([,:]?[0-9]+)?\\))?"
        ")"
      ]
    ];

    # 0 disables path hyperlinks.
    path_hyperlink_timeout_ms = 20;

    # ── Misc ───────────────────────────────────────────────────────────────
    show_count_badge = false;
    # "off" | "on"
    bell = "off";
  };
}
