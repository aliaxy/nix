# MacBook Pro M1 Pro — host-specific configuration.
# All shared modules are loaded by mkDarwinSystem in lib/; only values that
# differ per machine belong here.
{ pkgs, username, ... }:
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

      extraSystemPackages = with pkgs; [
      ];

      dock.extraPersistentApps = [
        "/System/Applications/Reminders.app"
        "/System/Applications/iPhone Mirroring.app"
        "/Users/${username}/Applications/Home Manager Apps/Ghostty.app"
        "/Applications/Google Chrome.app"
        "/Applications/Codex.app"
        "/Applications/Claude.app"
        "/Applications/Antigravity.app"
        "/Applications/Sublime Text.app"
        "/Applications/Zed.app"
        "/Applications/Orbstack.app"
        "/Applications/App Cleaner 9.app"
      ];

      dock.autohide = false;

      homebrew = {
        enableRosetta = true;
        extraBrews = [
          "xcodes"
        ];
        extraCasks = [
          "steam"
        ];
      };
    };
  };

  my.home.profiles = {
    base = true;
    dev = true;
  };
}
