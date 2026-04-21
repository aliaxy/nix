# lib/default.nix - Wrapper functions to keep flake.nix clean
{ inputs, self }:
{
  # Build a macOS system configuration using nix-darwin
  mkDarwinSystem =
    {
      # The hostname of the machine, must match a directory in hosts/
      hostname,
      # The primary user of the machine
      username,
      # The target architecture, defaults to Apple Silicon
      system ? "aarch64-darwin",
      # Any extra modules to include in the configuration
      extraModules ? [ ],
    }:
    inputs.nix-darwin.lib.darwinSystem {
      inherit system;
      # Pass these arguments to all modules so they can be used anywhere
      specialArgs = {
        inherit
          inputs
          self
          hostname
          username
          ;
      };
      modules = [
        # Load the host-specific configuration
        (../hosts + "/${hostname}")
        # Cross-platform common Nix settings
        ../modules/common/nix.nix
        # macOS system-level packages and default shell
        ../modules/darwin/packages.nix
        # macOS system preferences (Dock, Finder, Users)
        ../modules/darwin/system.nix
        # Homebrew management via nix-homebrew
        ../modules/darwin/homebrew.nix
        # Home Manager configuration and profile selection
        ../modules/darwin/home.nix
        # Load the nix-homebrew module for managing Homebrew
        inputs.nix-homebrew.darwinModules.nix-homebrew
        # Load the home-manager module for managing user environments
        inputs.home-manager.darwinModules.home-manager
      ]
      ++ extraModules;
    };
}
