# eza — 现代 ls 替代
{ ... }:
{
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
}
