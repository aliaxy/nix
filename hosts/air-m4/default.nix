# MacBook Air (M-series) host entry point
# Combine modules and set host-specific options
{
  username,
  hostname,
  ...
}:
{
  imports = [
    # Hardware-specific configuration (e.g., platform, state version)
    ./hardware.nix
    # Cross-platform common Nix settings
    ../../modules/common/nix.nix
    # macOS system-level packages and default shell
    ../../modules/darwin/packages.nix
    # macOS system preferences (Dock, Finder, Users)
    ../../modules/darwin/system.nix
    # Homebrew management via nix-darwin
    ../../modules/darwin/homebrew.nix
  ];

  # ---------------------------------------------------------
  # 主机专属配置 (Host-specific Configurations)
  # 这里的列表会自动与 modules/darwin/ 中的同名基础列表合并
  # ---------------------------------------------------------

  my = {
    darwin = {
      inherit hostname;
      timeZone = "Asia/Shanghai";

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

  # home-manager options (module injected by flake.nix)
  home-manager = {
    users.${username} = {
      imports = [
        # Main home-manager entry point
        ../../home
        # Essential CLI tools and shell environments
        ../../home/profiles/base.nix
        # Developer toolchain and configurations
        ../../home/profiles/dev.nix
        # GUI applications and window manager
        ../../home/profiles/desktop.nix
      ];
    };
  };
}
