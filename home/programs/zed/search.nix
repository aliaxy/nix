# Search: buffer/project search defaults and the file finder.
{
  # ── Search defaults ──────────────────────────────────────────────────────
  search = {
    button = true;
    whole_word = false;
    case_sensitive = false;
    include_ignored = false;
    regex = true;
    center_on_match = false;
  };

  search_wrap = true;

  # "always" | "selection" | "never"
  seed_search_query_from_cursor = "selection";

  use_smartcase_search = true;

  # ── File finder ──────────────────────────────────────────────────────────
  file_finder = {
    file_icons = true;

    # "small" | "medium" | "large" | "xlarge" | "full"
    modal_max_width = "small";

    skip_focus_for_active_in_search = true;

    # "all" | "indexed" | "smart"
    include_ignored = "smart";

    include_channels = false;
  };
}
