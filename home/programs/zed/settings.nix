# Full Zed settings: Zed's default schema as the base, with local overrides
# merged in. Keys owned by other modules (theme / icon_theme by catppuccin,
# auto_install_extensions by programs.zed-editor.extensions) are commented out
# where they would otherwise appear.
builtins.foldl' (acc: part: acc // part) {} [
  # {"$schema" = "zed://schemas/settings";}

  (import ./appearance.nix)
  (import ./workspace.nix)

  (import ./editor.nix)
  (import ./lsp.nix)
  (import ./completion.nix)
  (import ./diagnostics.nix)
  (import ./search.nix)

  (import ./panels.nix)
  (import ./git.nix)
  (import ./terminal.nix)
  (import ./agent.nix)

  (import ./languages.nix)
  (import ./files.nix)
  (import ./tasks-debug.nix)
  (import ./system.nix)
]
