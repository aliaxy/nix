# Homebrew package management (driven by nix-homebrew module)
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
    enableRosetta = mkEnableOption "Rosetta support for Apple Silicon Macs";

    extraBrews = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Additional Homebrew formulae for this host.";
    };

    extraCasks = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Additional Homebrew casks for this host.";
    };

    extraMasApps = mkOption {
      type = types.attrsOf types.int;
      default = { };
      description = "Additional App Store apps for this host.";
    };
  };

  config = {
    # Base nix-homebrew configuration
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
        cleanup = "zap";
      };
      greedyCasks = true;

      taps = [
        "nikitabobko/tap"
        "farion1231/ccswitch"
      ];

      brews = cfg.extraBrews;

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
