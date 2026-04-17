# lib/default.nix — 封装函数，让 flake.nix 保持简洁
{ inputs, self }:
{
  # 构建 macOS 系统
  mkDarwinSystem =
    {
      hostname,
      username,
      system ? "aarch64-darwin",
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
        (../hosts + "/${hostname}")
        inputs.nix-homebrew.darwinModules.nix-homebrew
        inputs.home-manager.darwinModules.home-manager
      ]
      ++ extraModules;
    };

  # 构建 NixOS 系统
  mkNixosSystem =
    {
      hostname,
      username,
      system ? "x86_64-linux",
      extraModules ? [ ],
    }:
    inputs.nixpkgs.lib.nixosSystem {
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
        (../hosts + "/${hostname}")
        inputs.home-manager.nixosModules.home-manager
      ]
      ++ extraModules;
    };
}
