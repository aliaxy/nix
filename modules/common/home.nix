# modules/common/home.nix — Home Manager base config and opt-in profile selection.
#
# Defines my.home.profiles.* and my.home.programs.* options and wires them to
# home-manager. Programs default to enabled; hosts can set individual ones to
# false to skip them.
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

    services = {
      ollama = mkEnableOption "Ollama local LLM service";
    };

    programs = {
      nvim = mkEnableOption "Neovim" // {
        default = true;
      };
      fish = mkEnableOption "Fish shell" // {
        default = true;
      };
      starship = mkEnableOption "Starship prompt" // {
        default = true;
      };
      yazi = mkEnableOption "Yazi file manager" // {
        default = true;
      };
      ghostty = mkEnableOption "Ghostty terminal" // {
        default = true;
      };
      aerospace = mkEnableOption "Aerospace tiling window manager" // {
        default = false;
      };
      zed = mkEnableOption "Zed editor" // {
        default = true;
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
    ]
    ++ lib.optionals (cfg.profiles.dev && cfg.programs.zed) [
      ../../home/programs/zed
    ]
    ++ lib.optionals cfg.services.ollama [
      { services.ollama.enable = true; }
    ]
    ++ lib.optionals (cfg.extraPackages != [ ]) [
      { home.packages = cfg.extraPackages; }
    ];
  };
}
