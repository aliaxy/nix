# MacBook Air M-series — host-specific configuration.
# All shared modules are loaded by mkDarwinSystem in lib/; only values that
# differ per machine belong here.
{ ... }:
{
  imports = [
    # Platform identity and nix-darwin state version
    ./hardware.nix
  ];

  # Host-specific option values.
  # These are merged with the base lists defined in the darwin modules.
  my = {
    darwin = {
      dock.extraPersistentApps = [
        "/System/Applications/Reminders.app"
        "/System/Applications/iPhone Mirroring.app"
        "/Applications/Nix Apps/Ghostty.app"
        "/Applications/Google Chrome.app"
        "/Applications/Notion.app"
        "/Applications/Sublime Text.app"
        "/Applications/Zed.app"
        "/Applications/Orbstack.app"
        "/Applications/App Cleaner 9.app"
      ];

      homebrew = {
        enableRosetta = true; # Apple Silicon: install the Intel prefix for Rosetta 2
        extraCasks = [
          "aerospace"
          "typora"
          "notion"
          "sublime-text"
          "zed"
          "antigravity"
          "orbstack"
          "qq"
          "wechat"
          "wechatwork"
          "feishu"
          "tencent-meeting"
          "microsoft-word"
          "microsoft-excel"
          "microsoft-powerpoint"
        ];
        extraMasApps = {
          "Pages" = 361309726;
          "Keynote" = 361285480;
          "Numbers" = 361304891;
        };
      };
    };
  };

  # Opt-in Home Manager profiles for this host
  my.home.profiles = {
    base = true;
    dev = true;
    desktop = true;
  };
}
