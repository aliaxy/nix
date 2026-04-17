# base profile — 最小通用配置，所有主机都用
{ ... }:
{
  imports = [
    ../programs/fish.nix
    ../programs/starship.nix
    ../programs/yazi.nix
  ];

  # bat — 带语法高亮的 cat 替代
  programs.bat.enable = true;

  # eza — 现代 ls 替代
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    colors = "always";
    icons = "always";
    extraOptions = [
      "--time-style"
      "+%Y-%m-%d %H:%M:%S"
      "--header"
      "--group-directories-first"
    ];
  };

  # zoxide — 智能 cd 替代
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

  # fastfetch — 系统信息展示
  programs.fastfetch = {
    enable = true;
    settings = { };
  };

  home.sessionVariables = {
    EZA_CONFIG_DIR = "$HOME/.config/eza";
  };

  home.file.".hushlogin".text = "";
}
