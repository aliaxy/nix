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
        # Load the nix-homebrew module for managing Homebrew
        inputs.nix-homebrew.darwinModules.nix-homebrew
        # Load the home-manager module for managing user environments
        inputs.home-manager.darwinModules.home-manager
      ]
      ++ extraModules;
    };

  # Build a Linux/NixOS system configuration using nixpkgs
  mkNixosSystem =
    {
      # The hostname of the machine, must match a directory in hosts/
      hostname,
      # The primary user of the machine
      username,
      # The target architecture, defaults to standard 64-bit Linux
      system ? "x86_64-linux",
      # Any extra modules to include in the configuration
      extraModules ? [ ],
    }:
    inputs.nixpkgs.lib.nixosSystem {
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
        # Load the home-manager module for managing user environments
        inputs.home-manager.nixosModules.home-manager
      ]
      ++ extraModules;
    };
}
