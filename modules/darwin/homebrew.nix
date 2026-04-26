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
  suiteApps = config.my.darwin.appBundles;

  caskType = types.coercedTo types.str (name: { inherit name; }) (
    types.submodule {
      options = {
        name = mkOption {
          type = types.str;
          description = "The name of the cask to install.";
        };
        greedy = mkOption {
          type = types.nullOr types.bool;
          default = true;
          description = "Whether to always upgrade this cask regardless of versioning.";
        };
      };
    }
  );

  # suite casks are plain strings; extraCasks may be strings or attrsets.
  # Build attrset maps keyed by name so that extraCasks overrides suite casks
  # with the same name via //.
  suiteCaskAttrs = builtins.listToAttrs (
    map (name: {
      inherit name;
      value = name;
    }) (builtins.filter (c: !(builtins.elem c cfg.excludeCasks)) suiteApps.casks)
  );
  extraCaskAttrs = builtins.listToAttrs (
    map (c: {
      name = c.name;
      value = c;
    }) cfg.extraCasks
  );
  mergedCasks = builtins.attrValues (suiteCaskAttrs // extraCaskAttrs);
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
      type = types.listOf caskType;
      default = [ ];
      description = ''
        Additional Homebrew casks to install on this host.
        Accepts plain strings or attrsets matching nix-darwin's homebrew.casks schema.
        Attrset entries with the same name as a suite cask override it.
      '';
    };

    excludeCasks = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Suite-derived Homebrew casks to exclude on this host.";
    };

    extraMasApps = mkOption {
      type = types.attrsOf types.int;
      default = { };
      description = "Additional Mac App Store apps to install on this host (name → Apple ID).";
    };

    excludeMasApps = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Suite-derived Mac App Store app names to exclude on this host.";
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

      casks = mergedCasks;

      masApps = suiteApps.masApps // cfg.extraMasApps;
    };
  };
}
