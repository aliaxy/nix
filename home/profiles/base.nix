# base profile — 最小通用配置，所有主机都启用
{ ... }:
{
  imports = [
    ../programs/shell/fish.nix
    ../programs/tools/zoxide.nix
    ../programs/tools/yazi.nix
    ../programs/tools/starship.nix
    ../programs/tools/eza.nix
    ../programs/tools/bat.nix
    ../programs/tools/fastfetch.nix
    ../programs/editor/nvim.nix
  ];

  home.sessionVariables = {
    EZA_CONFIG_DIR = "$HOME/.config/eza";
  };

  home.file.".hushlogin".text = "";
}
