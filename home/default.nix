# Home Manager entry point — imported by every host via home-manager.users.<name>
{ inputs, ... }:
{
  imports = [
    # Register the Catppuccin Home Manager module so catppuccin.* options are available
    inputs.catppuccin.homeModules.catppuccin
    # Centralized Catppuccin theme settings (flavor, accent, per-program toggles)
    ./catppuccin.nix
  ];

  # DO NOT change this value after the initial install, even when upgrading Home Manager.
  # It pins the state schema version and prevents silent breakage on incompatible releases.
  # See: https://nix-community.github.io/home-manager/release-notes.html
  home.stateVersion = "25.11";
}
