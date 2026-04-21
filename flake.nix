{
  description = "aliaxy's nix-darwin system flake";

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
      # Import builder functions (mkDarwinSystem) from lib/
      lib = import ./lib { inherit inputs self; };
    in
    {
      # Build and switch with:
      #   darwin-rebuild switch --flake .#air-m4
      darwinConfigurations."air-m4" = lib.mkDarwinSystem {
        hostname = "air-m4";
        username = "aliaxy";
      };
    };
}
