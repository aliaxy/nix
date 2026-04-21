# Neovim configuration
# Installs Neovim and links Lua config into ~/.config/nvim via xdg.configFile
# Plugins are managed at runtime by lazy.nvim (not Nix)
{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;

    viAlias = true;
    vimAlias = true;

    # System-level dependencies for LSP, search, etc.
    # Add language servers here as you enable them in LazyVim
    extraPackages = with pkgs; [
      # Search (required by Telescope / fzf-lua)
      ripgrep
      fd
    ];
  };

  # Link Lua config files into ~/.config/nvim/
  # lazy.nvim and plugins are installed at runtime into ~/.local/share/nvim/
  xdg.configFile."nvim" = {
    source = ./config;
    recursive = true;
  };
}
