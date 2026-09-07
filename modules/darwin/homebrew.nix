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
}: let
  inherit (lib) mkEnableOption mkOption types;
  cfg = config.my.darwin.homebrew;
  suiteApps = config.my.darwin.appBundles;

  caskType = types.coercedTo types.str (name: {inherit name;}) (
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
  # extraCasks override suite casks with the same name via //.
  # excludeCasks / excludeMasApps run after that merge so extras can be dropped too.
  caskName = c:
    if builtins.isAttrs c
    then c.name
    else c;

  suiteCaskAttrs = builtins.listToAttrs (
    map (name: {
      inherit name;
      value = name;
    })
    suiteApps.casks
  );
  extraCaskAttrs = builtins.listToAttrs (
    map (c: {
      inherit (c) name;
      value = c;
    })
    cfg.extraCasks
  );
  mergedCasks = builtins.filter (c: !(builtins.elem (caskName c) cfg.excludeCasks)) (
    builtins.attrValues (suiteCaskAttrs // extraCaskAttrs)
  );
  mergedMasApps = lib.filterAttrs (name: _: !(builtins.elem name cfg.excludeMasApps)) (
    suiteApps.masApps // cfg.extraMasApps
  );
in {
  options.my.darwin.homebrew = {
    # Enable Rosetta 2 so Homebrew can install x86_64 casks on Apple Silicon.
    enableRosetta = mkEnableOption "Rosetta support for Apple Silicon Macs";

    extraBrews = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Additional Homebrew formulae to install on this host.";
    };

    extraCasks = mkOption {
      type = types.listOf caskType;
      default = [];
      description = ''
        Additional Homebrew casks to install on this host.
        Accepts plain strings or attrsets matching nix-darwin's homebrew.casks schema.
        Attrset entries with the same name as a suite cask override it.
      '';
    };

    excludeCasks = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Homebrew casks to drop on this host, from suites or extraCasks.";
    };

    extraMasApps = mkOption {
      type = types.attrsOf types.int;
      default = {};
      description = "Additional Mac App Store apps to install on this host (name → Apple ID).";
    };

    excludeMasApps = mkOption {
      type = types.listOf types.str;
      default = [];
      description = "Mac App Store apps to drop on this host, from suites or extraMasApps.";
    };
  };

  config = {
    nix-homebrew = {
      enable = true;
      user = username;
      autoMigrate = true;
      inherit (cfg) enableRosetta;
    };

    homebrew = {
      enable = true;
      enableFishIntegration = true;

      onActivation = {
        autoUpdate = false;
        upgrade = true;
        # Remove packages that are no longer declared.
        cleanup = "zap";

        # darwin-rebuild activation runs under `env -i` + sudo and does not
        # inherit the interactive shell. Non-secret HOMEBREW_* flags go here.
        # Secrets (e.g. HOMEBREW_GITHUB_API_TOKEN for private taps/releases)
        # must NOT be set here — they land in the world-readable nix store.
        # Put them in ~/.homebrew/brew.env instead (chmod 600); brew loads it
        # itself when activation runs `sudo --user=… --set-home brew bundle`.
        extraEnv = {
          HOMEBREW_NO_ANALYTICS = "1";
          HOMEBREW_NO_ENV_HINTS = "1";
        };
      };

      # Always upgrade casks even if they self-report as up-to-date.
      greedyCasks = true;

      taps = [
        {
          name = "nikitabobko/tap";
          trusted = true;
        }
        {
          name = "aliaxy/tap";
          trusted = true;
        }
      ];

      brews = cfg.extraBrews;

      casks = mergedCasks;

      masApps = mergedMasApps;
    };
  };
}
