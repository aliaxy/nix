{
  description = "aliaxy nix-darwin system flake";

  # Flake inputs (dependencies)
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Flake outputs (configurations, packages, etc.)
  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
      catppuccin,
    }:
    let
      # Import custom helper functions for building systems (mkDarwinSystem, mkNixosSystem)
      lib = import ./lib { inherit inputs self; };
    in
    {
      # macOS system configurations
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#air-m4
      darwinConfigurations."air-m4" = lib.mkDarwinSystem {
        hostname = "air-m4";
        username = "aliaxy";
      };
    };
}
