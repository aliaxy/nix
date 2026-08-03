# Workspace: panes, window/session lifecycle, title/status/toolbar, tabs.
{
  # ── Panes and splits ─────────────────────────────────────────────────────
  active_pane_modifiers = {
    border_size = 0.8; # px
    inactive_opacity = 1.0; # 0–1
  };

  # "down" | "up"
  pane_split_direction_horizontal = "down";
  # "right" | "left"
  pane_split_direction_vertical = "right";

  # "contained" | "full" | "left_aligned" | "right_aligned"
  bottom_dock_layout = "full";

  centered_layout = {
    left_padding = 0.2;
    right_padding = 0.2;
  };

  # Which docks resize all their panels together: "left" "right" "bottom"
  resize_all_panels_in_dock = [];

  # Edge hot-zone ratio that turns a file drop into a split, 0–0.5.
  drop_target_size = 0.25;

  # ── Session and window lifecycle ─────────────────────────────────────────
  # "last_session" | "last_workspace" | "none"
  restore_on_startup = "last_session";

  restore_on_file_reopen = true;
  close_on_file_delete = false;
  close_panel_on_toggle = false;
  confirm_quit = false;

  # "platform_default" | "close_window" | "keep_window_open"
  when_closing_with_no_tabs = "platform_default";

  # "platform_default" | "quit_app"
  on_last_window_closed = "platform_default";

  session = {
    restore_unsaved_buffers = true;
    trust_all_worktrees = false;
  };

  # ── Where opened paths land ──────────────────────────────────────────────
  # "existing_window" | "new_window"
  cli_default_open_behavior = "existing_window";
  default_open_behavior = "existing_window";

  use_system_window_tabs = false;
  use_system_path_prompts = false;
  use_system_prompts = false;

  focus_follows_mouse = {
    enabled = false;
    debounce_ms = 250;
  };

  # ── Title bar ────────────────────────────────────────────────────────────
  title_bar = {
    show_branch_status_icon = false;
    show_branch_name = true;
    show_worktree_name = true;
    show_project_items = true;
    show_onboarding_banner = true;
    show_user_picture = true;
    show_user_menu = true;
    show_sign_in = true;
    show_menus = false;
    # Linux only.
    button_layout = "platform_default";
  };

  # ── Status bar ───────────────────────────────────────────────────────────
  status_bar = {
    "experimental.show" = true;
    show_active_file = false;
    active_language_button = true;
    cursor_position_button = true;
    line_endings_button = true;
    # "non_utf8" | "always" | "never"
    active_encoding_button = "non_utf8";
  };

  # "long" | "short"
  line_indicator_format = "short";

  # ── Editor toolbar ───────────────────────────────────────────────────────
  toolbar = {
    breadcrumbs = true;
    quick_actions = true;
    selections_menu = false;
    agent_review = true;
    code_actions = false;
  };

  # ── Tabs ─────────────────────────────────────────────────────────────────
  # null means unlimited.
  max_tabs = null;

  tab_bar = {
    show = true;
    show_nav_history_buttons = true;
    show_tab_bar_buttons = false;
    show_pinned_tabs_in_separate_row = false;
  };

  tabs = {
    git_status = true;
    # "right" | "left"
    close_position = "left";
    file_icons = true;
    # "hover" | "always" | "hidden"
    show_close_button = "hover";
    # "history" | "neighbour" | "left_neighbour"
    activate_on_close = "history";
    # "off" | "errors" | "all"; requires file_icons.
    show_diagnostics = "errors";
  };

  preview_tabs = {
    enabled = true;
    enable_preview_from_project_panel = true;
    enable_preview_from_file_finder = true;
    enable_preview_from_multibuffer = true;
    enable_preview_multibuffer_from_code_navigation = false;
    enable_preview_file_from_code_navigation = true;
    enable_keep_preview_on_code_navigation = false;
  };

  # ── Collaboration and audio ──────────────────────────────────────────────
  show_call_status_icon = true;

  calls = {
    mute_on_join = false;
    share_on_join = false;
  };

  audio = {
    # null follows the system default device.
    "experimental.output_audio_device" = null;
    "experimental.input_audio_device" = null;
  };
}
