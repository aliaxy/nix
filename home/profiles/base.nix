# base profile - minimal common configuration for all hosts
{ ... }:
{
  imports = [
    # Neovim configuration
    ../programs/nvim/nvim.nix
    # Shell configuration and alias definitions
    ../programs/fish.nix
    # Cross-shell customizable prompt
    ../programs/starship.nix
    # Blazing fast terminal file manager
    ../programs/yazi.nix
  ];

  # bat - cat replacement with syntax highlighting
  programs.bat.enable = true;

  # eza - modern ls replacement
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

  # zoxide - smart cd replacement
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

  # fastfetch - system information display
  programs.fastfetch = {
    enable = true;
    settings = { };
  };

  # Custom session variables for the base environment
  home.sessionVariables = {
    EZA_CONFIG_DIR = "$HOME/.config/eza";
  };

  # Disable the default login message on macOS/Linux
  home.file.".hushlogin".text = "";
}
