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
    base = mkEnableOption "base CLI and desktop profile (shell, editor, GUI apps)";
    dev = mkEnableOption "developer toolchain profile (git, direnv, AI tools, mirrors)";
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
      inputs.sops-nix.homeManagerModules.sops
    ]
    ++ lib.optionals cfg.base [ ../../home/profiles/base.nix ]
    ++ lib.optionals cfg.dev [ ../../home/profiles/dev.nix ];
  };
}
