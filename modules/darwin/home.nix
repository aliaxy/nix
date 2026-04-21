# modules/darwin/home.nix — Home Manager base config and opt-in profile selection.
#
# Defines `my.home.profiles.*` options that let each host declare which user
# environment profiles to activate.  The module wires those options to the
# corresponding home-manager import list, so hosts never have to touch
# home-manager internals directly.
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
    base = mkEnableOption "base CLI profile (shell, editor, core CLI tools)";
    dev = mkEnableOption "developer toolchain profile (git, go, rust, python, AI tools)";
    desktop = mkEnableOption "desktop GUI profile (terminal, editor, window manager)";
  };

  config = {
    # Pass flake inputs and host identity into every Home Manager module.
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit inputs username hostname; };
    };

    home-manager.users.${username}.imports = [
      ../../home
    ]
    ++ lib.optionals cfg.base [ ../../home/profiles/base.nix ]
    ++ lib.optionals cfg.dev [ ../../home/profiles/dev.nix ]
    ++ lib.optionals cfg.desktop [ ../../home/profiles/desktop.nix ];
  };
}
