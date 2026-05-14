# modules/common/home.nix — Home Manager base config and opt-in profile selection.
#
# Defines my.home.profiles.* options and wires them to home-manager.
# The home-manager module API is identical on Darwin and NixOS, so this
# module is shared across all platforms.
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
  cfg = config.my.home.profiles;
in
{
  options.my.home.profiles = {
    base = mkEnableOption "base CLI and desktop profile (shell, editor, GUI apps)";
    dev = mkEnableOption "developer toolchain profile (git, direnv, AI tools, mirrors)";
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
    ++ lib.optionals cfg.base [ ../../home/profiles/base.nix ]
    ++ lib.optionals cfg.dev [ ../../home/profiles/dev.nix ];
  };
}
