# Homebrew package management (driven by nix-homebrew module)
{ ... }:
{
  homebrew = {
    enable = true;
    enableFishIntegration = true;
    onActivation = {
      autoUpdate = false;
      upgrade = true;
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
      "google-chrome"
      "app-cleaner"

      "clash-verge-rev"
      "cc-switch"

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

      "sf-symbols"
      "font-sf-pro"
      "font-sf-mono"
    ];

    masApps = {
      "Pages" = 361309726;
      "Keynote" = 361285480;
      "Numbers" = 361304891;
    };
  };
}
