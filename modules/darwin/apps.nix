# modules/darwin/apps.nix
#
# Reusable GUI app bundles for macOS hosts.
# Hosts opt into high-level roles instead of duplicating long cask lists in
# every host file.
{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption types;
  roleCfg = config.my.darwin.roles;
  homebrewCfg = config.my.darwin.homebrew;
  roleMasApps = lib.mkMerge [
    (lib.optionalAttrs roleCfg.iWork {
      "Pages" = 361309726;
      "Keynote" = 361285480;
      "Numbers" = 361304891;
    })
  ];
in
{
  options = {
    my.darwin.roles = {
      essentials = mkEnableOption "shared desktop essentials (browser, terminal, fonts, utilities)";
      development = mkEnableOption "GUI development tools (window manager, editors, containers)";
      productivity = mkEnableOption "writing and knowledge-work apps";
      communication = mkEnableOption "chat and meeting apps";
      office = mkEnableOption "Microsoft Office desktop apps";
      iWork = mkEnableOption "Apple iWork apps from the Mac App Store";
    };

    my.darwin.appBundles = {
      casks = mkOption {
        type = types.listOf types.str;
        internal = true;
        default = [ ];
        description = "Resolved Homebrew casks enabled by the selected Darwin roles.";
      };

      masApps = mkOption {
        type = types.attrsOf types.int;
        internal = true;
        default = { };
        description = "Resolved Mac App Store apps enabled by the selected Darwin roles.";
      };
    };
  };

  config.my.darwin.appBundles = {
    casks = lib.unique (
      lib.flatten [
        (lib.optionals roleCfg.essentials [
          "keka"
          "ghostty"
          "google-chrome"
          "app-cleaner"
          "clash-verge-rev"
          "cc-switch"
          "sf-symbols"
          "font-sf-pro"
          "font-sf-mono"
        ])
        (lib.optionals roleCfg.development [
          "sublime-text"
          "zed"
          "antigravity"
          "orbstack"
        ])
        (lib.optionals roleCfg.productivity [
          "aerospace"
          "notion"
          "typora"
        ])
        (lib.optionals roleCfg.communication [
          "qq"
          "wechat"
          "wechatwork"
          "feishu"
          "tencent-meeting"
        ])
        (lib.optionals roleCfg.office [
          "microsoft-word"
          "microsoft-excel"
          "microsoft-powerpoint"
        ])
      ]
    );

    masApps = lib.filterAttrs (name: _: !(builtins.elem name homebrewCfg.excludeMasApps)) roleMasApps;
  };
}
