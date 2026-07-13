# System-level packages, fonts, and shell registration for macOS hosts.
{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.my.darwin.extraSystemPackages = mkOption {
    type = types.listOf types.package;
    default = [];
    description = "Host-specific packages added to environment.systemPackages.";
  };

  config = {
    environment.systemPackages =
      (with pkgs; [
        mas # Mac App Store CLI
        ascii-image-converter # ASCII art converter
      ])
      ++ config.my.darwin.extraSystemPackages;

    fonts.packages = [
      pkgs.nerd-fonts.jetbrains-mono
    ];

    # Register fish so nix-darwin adds it to /etc/shells.
    programs.fish.enable = true;
    environment.shells = [pkgs.fish];
  };
}
