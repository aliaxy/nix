# Base profile — core CLI and desktop environment shared across all hosts.
{ ... }:
{
  imports = [
    ../programs/nvim
    ../programs/fish.nix
    ../programs/starship.nix
    ../programs/yazi.nix
    ../programs/ghostty.nix
    ../programs/aerospace.nix
  ];

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
