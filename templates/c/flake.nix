{
  description = "C/C++ development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            clang
            cmake
            ninja
            clang-tools
            bear
            pkg-config
          ];

          shellHook = ''
            export CC=clang
            export CXX=clang++
          '';
        };
      }
    );
}
