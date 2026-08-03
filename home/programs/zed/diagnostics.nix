# Diagnostics: pull mechanism and inline presentation.
{
  # Editor rendering cap only; does not affect fetching or the project panel.
  # "off" | "error" | "warning" | "info" | "hint" | "all"
  diagnostics_max_severity = "all";

  diagnostics = {
    button = true;
    include_warnings = true;

    lsp_pull_diagnostics = {
      enabled = true;
      # 0 disables debouncing.
      debounce_ms = 200;
    };

    inline = {
      enabled = true;
      update_debounce_ms = 150;
      # Gap after the line end, in em widths.
      padding = 2;
      # Minimum start column; longer lines still push further right.
      min_column = 0;
      # null inherits diagnostics_max_severity.
      max_severity = "warning";
    };
  };
}
