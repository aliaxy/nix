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
    nix-homebrew.inputs.brew-src.url = "github:Homebrew/brew/main";

    # home-manager: user-level dotfiles and program configuration.
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # catppuccin: upstream Nix module that wires the Catppuccin palette into
    # supported Home Manager programs (bat, starship, ghostty, eza, yazi …).
    catppuccin.url = "github:catppuccin/nix";
    catppuccin.inputs.nixpkgs.follows = "nixpkgs";

    # flake-parts: module-based flake composition.
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    flake-parts,
    self,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: {
        formatter = pkgs.alejandra;

        # Force-eval each Darwin host without building the system closure.
        # `nix flake check` then stays a cheap eval instead of a full rebuild.
        checks = pkgs.lib.optionalAttrs (system == "aarch64-darwin") {
          eval-mba-m4 = pkgs.runCommand "eval-mba-m4" {} ''
            echo ${self.darwinConfigurations.mba-m4.config.system.build.toplevel.drvPath} > $out
          '';
          eval-mbp-m1pro = pkgs.runCommand "eval-mbp-m1pro" {} ''
            echo ${self.darwinConfigurations.mbp-m1pro.config.system.build.toplevel.drvPath} > $out
          '';
        };
      };

      flake = let
        lib = import ./lib {inherit inputs self;};
      in {
        # Build and switch with:
        #   darwin-rebuild switch --flake .#mba-m4
        darwinConfigurations."mba-m4" = lib.mkDarwinSystem {
          hostname = "mba-m4";
          username = "aliaxy";
        };

        # Build and switch with:
        #   darwin-rebuild switch --flake .#mbp-m1pro
        darwinConfigurations."mbp-m1pro" = lib.mkDarwinSystem {
          hostname = "mbp-m1pro";
          username = "aliaxy";
        };
      };
    };
}
