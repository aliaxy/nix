# MacBook Air M4 — host-specific configuration.
# All shared modules are loaded by mkDarwinSystem in lib/; only values that
# differ per machine belong here.
{ ... }:
{
  imports = [
    # Platform identity and nix-darwin state version
    ./hardware.nix
  ];

  # Host-specific option values.
  # These are merged with the reusable base lists defined in the darwin modules.
  my = {
    darwin = {
      suites = {
        essentials = true;
        development = true;
        productivity = true;
        communication = true;
        office = true;
        iWork = true;
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
        enableRosetta = true; # Apple Silicon: install the Intel prefix for Rosetta 2
        extraCasks = [
          "feishu"
          "tencent-meeting"
          "wechatwork"
          "codex-app"
          "claude"
          "capcut"
          {
            name = "microsoft-word";
          #  greedy = false;
          }
          {
            name = "microsoft-excel";
          #  greedy = false;
          }
          {
            name = "microsoft-powerpoint";
          #  greedy = false;
          }
        ];
      };
    };
  };

  # Opt-in Home Manager profiles for this host
  my.home.profiles = {
    base = true;
    dev = true;
  };

  my.home.programs.aerospace = true;
}
