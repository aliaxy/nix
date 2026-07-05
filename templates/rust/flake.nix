{
  description = "Rust development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      rust-overlay,
      nixpkgs,
      devshell,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        devshell.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { system, ... }:
        let
          pkgs = import nixpkgs {
            inherit system;

            overlays = [
              rust-overlay.overlays.default
            ];
          };

          rustToolchain =
            if builtins.pathExists ./rust-toolchain.toml then
              pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml
            else if builtins.pathExists ./rust-toolchain then
              pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain
            else
              pkgs.rust-bin.stable.latest.default.override {
                extensions = [
                  "rust-src"
                  "rust-analyzer"
                  "clippy"
                  "rustfmt"
                ];
              };
        in
        {
          formatter = pkgs.nixfmt-tree;

          devshells.default = {
            devshell.name = "xxx project";

            devshell.motd = ''
              {202}xxx project{reset}
              $(type -p menu &>/dev/null && menu)
            '';

            packages = [
              rustToolchain
            ];

            env = [
              {
                name = "RUST_BACKTRACE";
                value = "1";
              }
            ];

            commands = [
              {
                name = "xxx-check";
                category = "Quality Assurance";
                help = "Run cargo check and clippy for the whole workspace";
                command = ''
                  cargo check --workspace
                  cargo clippy --workspace --all-targets -- -D warnings
                '';
              }

              {
                name = "xxx-test";
                category = "Testing";
                help = "Run all workspace tests";
                command = "cargo test --workspace";
              }

              {
                name = "xxx-nextest";
                category = "Testing";
                help = "Run tests with cargo-nextest";
                command = "cargo nextest run --workspace";
              }

              {
                name = "xxx-fmt";
                category = "Quality Assurance";
                help = "Format Rust and Nix files";
                command = ''
                  cargo fmt --all
                  nix fmt
                '';
              }
            ];

          };
        };
    };
}
