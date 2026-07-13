# Base profile — core CLI environment shared across all hosts.
# Long program configs (nvim, fish, starship, yazi, ghostty) are split under
# home/programs/ and always imported with this profile from modules/common/home.nix.
{ ... }:
{
  # bat: syntax-highlighted cat replacement
  programs.bat.enable = true;

  # eza: modern ls replacement with icons and git integration
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

  # zoxide: frecency-based cd replacement (mapped to `cd`)
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

  # fastfetch: system information display
  programs.fastfetch = {
    enable = true;
    settings = { };
  };

  home.sessionVariables = {
    EZA_CONFIG_DIR = "$HOME/.config/eza";
  };

  # Suppress the default MOTD on login
  home.file.".hushlogin".text = "";
}
