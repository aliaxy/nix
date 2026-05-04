{
  description = "aliaxy's nix-darwin system flake";

  inputs = {
    # Core package set — track the rolling unstable branch for latest software.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # nix-darwin: macOS system configuration (Homebrew, defaults, activation scripts).
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # nix-homebrew: declarative Homebrew tap/cask/brew management via nix-darwin.
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # home-manager: user-level dotfiles and program configuration.
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # catppuccin: upstream Nix module that wires the Catppuccin palette into
    # supported Home Manager programs (bat, starship, ghostty, eza, yazi …).
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    # sops-nix: declarative secrets management via SOPS + age encryption.
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self, ... }:
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
