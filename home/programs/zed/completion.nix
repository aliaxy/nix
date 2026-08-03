# Completions: trigger behaviour, word-completion fallback, menu appearance.
{
  # ── Trigger ──────────────────────────────────────────────────────────────
  show_completions_on_input = true;
  show_completion_documentation = true;

  completions = {
    # "enabled" | "fallback" | "disabled"
    words = "fallback";

    words_min_length = 1;

    lsp = true;

    # Per-server response timeout; 0 waits indefinitely.
    lsp_fetch_timeout_ms = 500;

    # "insert" | "replace" | "replace_subsequence" | "replace_suffix"
    lsp_insert_mode = "replace_suffix";
  };

  # ── Menu appearance ──────────────────────────────────────────────────────
  # "auto" | "system" | "always" | "never"
  completion_menu_scrollbar = "never";

  # "left" | "right"
  completion_detail_alignment = "right";

  # "off" | "symbol"
  completion_menu_item_kind = "symbol";

  # "top" | "inline" | "bottom" | "none"
  snippet_sort_order = "inline";
}
