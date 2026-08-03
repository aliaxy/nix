# Git: gutter status, inline blame, diff views, and the git panel.
{
  git = {
    # ── Master switches ────────────────────────────────────────────────────
    disable_git = false;
    enable_status = true;
    enable_diff = true;

    # ── Gutter ─────────────────────────────────────────────────────────────
    # "tracked_files" | "hide"
    git_gutter = "tracked_files";
    gutter_debounce = 0;

    # ── Inline blame ───────────────────────────────────────────────────────
    inline_blame = {
      enabled = true;
      # Reset on every cursor move; 0 shows it as soon as the cursor rests.
      delay_ms = 0;
      # "inline"
      location = "inline";
      # Gap after the line end, in em widths.
      padding = 2;
      show_commit_summary = false;
      min_column = 0;
    };

    blame = {
      show_avatar = true;
    };

    branch_picker = {
      show_author_name = true;
    };

    # ── Diff presentation ──────────────────────────────────────────────────
    # "staged_hollow" | "unstaged_hollow"
    hunk_style = "staged_hollow";

    show_stage_restore_buttons = true;

    # "file_name_first" | "file_path_first"
    path_style = "file_name_first";

    file_diff = {
      show_full_file = true;
    };

    # ── Worktrees ──────────────────────────────────────────────────────────
    # Relative to the repository working directory. When it resolves outside
    # the project root the project directory name is appended, so
    # "../worktrees" for ~/code/zed becomes ~/code/worktrees/zed/.
    worktree_directory = "../worktrees";
  };

  # ── Git panel ────────────────────────────────────────────────────────────
  git_panel = {
    button = true;
    dock = "left";
    default_width = 360;
    starts_open = false;

    # "icon" | "label_color"
    status_style = "label_color";
    file_icons = true;
    folder_icons = true;

    # Used when git's init.defaultBranch is unset.
    fallback_branch_name = "main";

    sort_by = "path";
    group_by = "status";
    tree_view = false;
    collapse_untracked_diff = false;

    show_count_badge = true;
    diff_stats = true;
    # 0 disables the commit title length warning.
    commit_title_max_length = 0;

    # "project_diff" | "file_diff" | "view_file"
    entry_primary_click_action = "project_diff";

    scrollbar = {
      # null inherits the editor setting.
      # "auto" | "system" | "always" | "never"
      show = null;
    };
  };

  # ── Self-hosted git providers ────────────────────────────────────────────
  # { provider = "github"; name = "..."; base_url = "https://..."; }
  git_hosting_providers = [];

  # ── Diff view ────────────────────────────────────────────────────────────
  # "split" | "unified"
  diff_view_style = "split";

  # Editors narrower than this (in em) fall back to unified; 0 disables the
  # automatic switch.
  minimum_split_diff_width = 100;

  word_diff_enabled = true;
}
