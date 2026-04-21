# Home Manager profile selection (driven by nix-darwin module)
# Defines my.home.profiles.* options and wires them to home-manager imports
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
