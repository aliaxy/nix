# Builder functions that abstract away boilerplate for defining new hosts.
{ inputs, self }:
{
  # Build a macOS (nix-darwin) system configuration.
  mkDarwinSystem =
    {
      # Must match a directory name under hosts/
      hostname,
      # Primary user of the machine
      username,
      # Target architecture; defaults to Apple Silicon
      system ? "aarch64-darwin",
      # Additional modules to merge into the configuration
      extraModules ? [ ],
    }:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = {
        inherit
          inputs
          self
          hostname
          username
          ;
      };
      modules = [
        # Host-specific configuration (hardware, overrides)
        (../hosts + "/${hostname}")
        # Shared Nix daemon settings
        ../modules/common/nix.nix
        # System-level packages, fonts, and shell registration
        ../modules/darwin/packages.nix
        # macOS system preferences (Dock, Finder, users)
        ../modules/darwin/system.nix
        # Homebrew management via nix-homebrew
        ../modules/darwin/homebrew.nix
        # Home Manager base config and opt-in profile selection
        ../modules/darwin/home.nix
        # Third-party modules
        inputs.agenix.darwinModules.default
        inputs.nix-homebrew.darwinModules.nix-homebrew
        inputs.home-manager.darwinModules.home-manager
      ]
      ++ extraModules;
    };
}
