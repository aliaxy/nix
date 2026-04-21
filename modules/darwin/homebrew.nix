# modules/darwin/homebrew.nix
#
# Homebrew package management via nix-homebrew.
# Defines `my.darwin.homebrew.*` options for host-level customisation
# and wires them into the nix-homebrew / homebrew-nix module options.
{
  config,
  lib,
  username,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption types;
  cfg = config.my.darwin.homebrew;
in
{
  options.my.darwin.homebrew = {
    # Enable Rosetta 2 so Homebrew can install x86_64 casks on Apple Silicon.
    enableRosetta = mkEnableOption "Rosetta support for Apple Silicon Macs";

    extraBrews = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Additional Homebrew formulae to install on this host.";
    };

    extraCasks = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Additional Homebrew casks to install on this host.";
    };

    extraMasApps = mkOption {
      type = types.attrsOf types.int;
      default = { };
      description = "Additional Mac App Store apps to install on this host (name → Apple ID).";
    };
  };

  config = {
    nix-homebrew = {
      enable = true;
      user = username;
      autoMigrate = true;
      enableRosetta = cfg.enableRosetta;
    };

    homebrew = {
      enable = true;
      enableFishIntegration = true;

      onActivation = {
        autoUpdate = false;
        upgrade = true;
        # Remove packages that are no longer declared.
        cleanup = "zap";
      };

      # Always upgrade casks even if they self-report as up-to-date.
      greedyCasks = true;

      taps = [
        "nikitabobko/tap"
        "farion1231/ccswitch"
      ];

      brews = cfg.extraBrews;

      # Base casks present on every macOS host.
      casks = [
        "google-chrome"
        "app-cleaner"
        "clash-verge-rev"
        "cc-switch"
        "sf-symbols"
        "font-sf-pro"
        "font-sf-mono"
      ]
      ++ cfg.extraCasks;

      masApps = cfg.extraMasApps;
    };
  };
}
