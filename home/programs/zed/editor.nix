# Editor core: cursor, selection, indentation, wrapping, save hooks, scrolling.
{
  # ── Cursor ───────────────────────────────────────────────────────────────
  cursor_blink = true;

  # "bar" | "block" | "underline" | "hollow"
  cursor_shape = "bar";

  # "never" | "on_typing" | "on_typing_and_action"
  hide_mouse = "on_typing_and_action";

  # ── Selection and current line ───────────────────────────────────────────
  # "none" | "gutter" | "line" | "all"
  current_line_highlight = "gutter";

  selection_highlight = true;
  rounded_selection = true;

  # Rainbow brackets; colours come from the theme's accents.
  colorize_brackets = true;

  # ── Indentation ──────────────────────────────────────────────────────────
  hard_tabs = false;
  # Python / Rust override this back to 4 in languages.nix.
  tab_size = 2;

  # "syntax_aware" | "preserve_indent" | "none"
  auto_indent = "syntax_aware";

  auto_indent_on_paste = true;

  # ── Wrapping and guides ──────────────────────────────────────────────────
  # "none" | "editor_width" | "bounded"
  soft_wrap = "none";
  preferred_line_length = 80;

  # Draws a guide at preferred_line_length only when soft_wrap = "bounded",
  # plus any columns listed in wrap_guides.
  show_wrap_guides = true;
  wrap_guides = [];

  # ── Whitespace ───────────────────────────────────────────────────────────
  # "selection" | "none" | "all" | "boundary" | "trailing"
  show_whitespaces = "selection";

  whitespace_map = {
    space = "•";
    tab = "→";
  };

  # ── Brackets and auto-pairing ────────────────────────────────────────────
  use_autoclose = true;
  use_auto_surround = true;

  # true treats every closing bracket as auto-inserted, not just the ones
  # Zed added itself.
  always_treat_brackets_as_autoclosed = true;

  # editor::Rewrap scope: "in_comments" | "in_selections" | "anywhere"
  allow_rewrap = "in_comments";

  # ── Newline continuation ─────────────────────────────────────────────────
  extend_comment_on_newline = true;
  extend_list_on_newline = true;
  indent_list_on_tab = true;

  # ── Save and formatting ──────────────────────────────────────────────────
  # "off" | "on_window_change" | "on_focus_change" |
  # { after_delay = { milliseconds = 500; }; }
  autosave = "off";

  # "on" | "off" | "modifications" | "modifications_if_available"
  # Ignored when autosave uses after_delay.
  format_on_save = "on";

  # "auto" (Prettier first, then LSP) | "language_server" | "prettier" |
  # { language_server = { name = "ruff"; }; } |
  # { external = { command = "..."; arguments = [...]; }; } |
  # { code_action = "source.fixAll.eslint"; } | a list applied in order
  formatter = "auto";

  remove_trailing_whitespace_on_save = true;
  ensure_final_newline_on_save = true;

  # "detect" | "prefer_lf" | "prefer_crlf" | "enforce_lf" | "enforce_crlf"
  # EditorConfig end_of_line overrides this.
  line_ending = "detect";

  # ── Gutter and indent guides ─────────────────────────────────────────────
  gutter = {
    line_numbers = true;
    runnables = true;
    bookmarks = true;
    breakpoints = true;
    folds = true;
    min_line_number_digits = 4;
  };

  indent_guides = {
    enabled = true;
    line_width = 1; # 1–10
    active_line_width = 2; # 1–10
    # "disabled" | "fixed" | "indent_aware"
    coloring = "indent_aware";
    # "disabled" | "indent_aware"
    background_coloring = "disabled";
  };

  # ── Scrollbar and minimap ────────────────────────────────────────────────
  scrollbar = {
    # "auto" | "system" | "always" | "never"
    show = "auto";
    cursors = true;
    git_diff = true;
    search_results = true;
    selected_text = true;
    selected_symbol = true;
    # "none"/false | "error" | "warning" | "information" | "all"/true
    diagnostics = "all";
    axes = {
      horizontal = false;
      vertical = true;
    };
  };

  minimap = {
    # "auto" | "always" | "never"
    show = "never";
    # "active_editor" | "all_editors"
    display_in = "active_editor";
    # "hover" | "always"
    thumb = "always";
    # "full" | "left_open" | "right_open" | "left_only" | "none"
    thumb_border = "left_open";
    # null inherits current_line_highlight;
    # "line" | "all" | "gutter" | "none"
    current_line_highlight = null;
    max_width_columns = 80;
  };

  # ── Scrolling ────────────────────────────────────────────────────────────
  sticky_scroll = {
    enabled = false;
  };

  relative_line_numbers = "enabled";

  # "off" | "one_page"
  scroll_beyond_last_line = "one_page";

  vertical_scroll_margin = 8;
  horizontal_scroll_margin = 5;

  autoscroll_on_clicks = false;

  scroll_sensitivity = 1.0;
  # Multiplier while alt/option is held.
  fast_scroll_sensitivity = 4.0;

  mouse_wheel_zoom = false;

  # ── Mouse ────────────────────────────────────────────────────────────────
  # "alt" | "cmd_or_ctrl" (aliases "cmd" / "ctrl")
  multi_cursor_modifier = "alt";

  # Linux only.
  middle_click_paste = true;

  drag_and_drop_selection = {
    enabled = true;
    # Hold time before a drag starts instead of a new selection.
    delay = 150;
  };

  # ── Multibuffer ──────────────────────────────────────────────────────────
  # "select" | "open"
  double_click_in_multibuffer = "select";

  expand_excerpt_lines = 5;
  excerpt_context_lines = 2;

  # ── Hover popover ────────────────────────────────────────────────────────
  hover_popover_enabled = true;
  hover_popover_delay = 150;
  hover_popover_sticky = true;
  # Only applies when hover_popover_sticky is enabled.
  hover_popover_hiding_delay = 300;

  # ── Modeline ─────────────────────────────────────────────────────────────
  # Lines scanned at each end of a file for vim/emacs directives; 0 disables.
  modeline_lines = 0;
}
