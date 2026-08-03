# Tasks, debugger and DAP, Jupyter/REPL.
{
  # ── Tasks ────────────────────────────────────────────────────────────────
  tasks = {
    enabled = true;
    variables = {};
    # Prefer LSP-provided tasks over extension-provided ones; falls back when
    # the server errors, times out, or returns nothing.
    prefer_lsp = true;
  };

  # ── Debugger ─────────────────────────────────────────────────────────────
  debugger = {
    # "line" | "statement" | "instruction"
    stepping_granularity = "line";
    save_breakpoints = true;
    timeout = 2000;
    # "left" | "right" | "bottom"
    dock = "right";
    log_dap_communications = false;
    format_dap_log_messages = false;
    button = true;
  };

  # Per-adapter configuration, keyed by adapter name.
  dap = {
    CodeLLDB = {
      env = {
        RUST_LOG = "info";
      };
    };
  };

  # ── Jupyter ──────────────────────────────────────────────────────────────
  jupyter = {
    enabled = true;
    # Language name to kernel name, e.g. python = "conda-base";
    kernel_selections = {};
  };

  # ── REPL ─────────────────────────────────────────────────────────────────
  repl = {
    # Clamped to [20, 512].
    max_columns = 128;
    # Clamped to [4, 256].
    max_lines = 32;
    # 0 removes the height limit.
    output_max_height_lines = 20;
  };
}
