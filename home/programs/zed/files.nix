# File visibility, scan scope, and privacy.
{
  # ── Privacy ──────────────────────────────────────────────────────────────
  private_files = [
    "**/.env*"
    "**/*.pem"
    "**/*.key"
    "**/*.cert"
    "**/*.crt"
    "**/secrets.yml"
    "**/*.env"
  ];

  redact_private_values = false;

  # ── Scanning ─────────────────────────────────────────────────────────────
  # Never scanned, searched, or shown in the project tree.
  # Appended to the built-in defaults; wins over file_scan_inclusions.
  file_scan_exclusions = [
    "**/.git"
    "**/.svn"
    "**/.hg"
    "**/.jj"
    "**/.sl"
    "**/.repo"
    "**/CVS"
    "**/.DS_Store"
    "**/Thumbs.db"
    "**/.classpath"
    "**/.settings"
  ];

  # Indexed even when git-ignored. Also appended; overly broad globs slow
  # scanning down.
  file_scan_inclusions = [
    ".env*"
    "**/.direnv"
  ];

  # "expanded" | "always"
  scan_symlinks = "expanded";

  # ── Visibility and read-only ─────────────────────────────────────────────
  # Paired with project_panel.hide_hidden.
  hidden_files = ["**/.*"];

  # Viewable but not editable.
  read_only_files = [
    "**/flake.lock"
  ];
}
