# MacBook Air (M-series) host entry point
# Combine modules and set host-specific options
{ ... }:
{
  imports = [
    # Hardware-specific configuration (platform, state version)
    ./hardware.nix
  ];

  # ---------------------------------------------------------
  # 主机专属配置 (Host-specific Configurations)
  # 这里的列表会自动与 modules/darwin/ 中的同名基础列表合并
  # ---------------------------------------------------------

  my = {
    darwin = {
      dock = {
        position = "bottom";
        tileSize = 64;
        extraPersistentApps = [
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
      };

      homebrew = {
        enableRosetta = true; # Apple Silicon: install Intel prefix for Rosetta
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

  my.home.profiles = {
    base = true;
    dev = true;
    desktop = true;
  };
}
