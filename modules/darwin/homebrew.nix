# Homebrew 软件包管理（由 nix-homebrew 模块驱动）
{ ... }:
{
  homebrew = {
    enable = true;
    enableFishIntegration = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    greedyCasks = true;

    taps = [
      "nikitabobko/tap"
      "farion1231/ccswitch"
    ];

    brews = [ ];

    casks = [
      "aerospace"
      "cc-switch"
      "orbstack"
      "qq"
      "wechat"
      "wechatwork"
      "tencent-meeting"
      "google-chrome"
      "zed"
      "antigravity"
      "notion"
      "typora"
      "sublime-text"
      "clash-verge-rev"
      "app-cleaner"
      "feishu"
      "sf-symbols"
      "font-sf-pro"
      "font-sf-mono"
      "microsoft-word"
      "microsoft-excel"
      "microsoft-powerpoint"
    ];

    masApps = {
      "Pages" = 361309726;
      "Keynote" = 361285480;
      "Numbers" = 361304891;
    };
  };
}
