# modules/common/home.nix — Home Manager base config and opt-in profile selection.
#
# Profiles pull in their programs as a unit. Large program configs live under
# home/programs/ for readability, not as independent opt-in features.
# Only aerospace is host-toggleable (default off).
{
  config,
  lib,
  inputs,
  username,
  hostname,
  ...
}:
let
  inherit (lib) mkEnableOption;
  cfg = config.my.home;
in
{
  options.my.home = {
    profiles = {
      base = mkEnableOption "base CLI and desktop profile (shell, editor, GUI apps)";
      dev = mkEnableOption "developer toolchain profile (git, direnv, AI tools, mirrors)";
    };

    programs = {
      aerospace = mkEnableOption "Aerospace tiling window manager" // {
        default = false;
      };
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Host-specific home packages to install alongside the shared profiles.";
    };
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs username hostname; };
    };

    home-manager.users.${username}.imports = [
      ../../home
    ]
    ++ lib.optionals cfg.profiles.base [
      ../../home/profiles/base.nix
      # Split files for long configs — always part of base, not individual toggles.
      ../../home/programs/nvim
      ../../home/programs/fish.nix
      ../../home/programs/starship.nix
      ../../home/programs/yazi.nix
      ../../home/programs/ghostty.nix
    ]
    ++ lib.optionals (cfg.profiles.base && cfg.programs.aerospace) [
      ../../home/programs/aerospace.nix
    ]
    ++ lib.optionals cfg.profiles.dev [
      ../../home/profiles/dev.nix
      ../../home/programs/zed
    ]
    ++ lib.optionals (cfg.extraPackages != [ ]) [
      { home.packages = cfg.extraPackages; }
    ];
  };
}
