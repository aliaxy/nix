# MacBook Pro M1 Pro — host-specific configuration.
# All shared modules are loaded by mkDarwinSystem in lib/; only values that
# differ per machine belong here.
{ ... }:
{
  imports = [
    ./hardware.nix
  ];

  my = {
    darwin = {
      suites = {
        essentials = true;
        development = true;
        productivity = true;
        communication = true; # qq + wechat
        office = false;
        iWork = false;
      };

      dock.extraPersistentApps = [
        "/System/Applications/Reminders.app"
        "/System/Applications/iPhone Mirroring.app"
        "/Users/aliaxy/Applications/Home Manager Apps/Ghostty.app"
        "/Applications/Google Chrome.app"
        "/Applications/Notion.app"
        "/Applications/Sublime Text.app"
        "/Applications/Zed.app"
        "/Applications/Orbstack.app"
        "/Applications/App Cleaner 9.app"
      ];

      homebrew = {
        enableRosetta = true;
        extraCasks = [
          "codex-app"
          "claude"
        ];
      };
    };
  };

  my.home.profiles = {
    base = true;
    dev = true;
  };
}
