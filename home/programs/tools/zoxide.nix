# zoxide — 智能 cd 替代
{ ... }:
{
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };
}
