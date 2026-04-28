# Neovim — editor configuration
#
# Installs Neovim via Home Manager and symlinks the Lua config tree into
# ~/.config/nvim/ using xdg.configFile.  Plugins are managed at runtime
# by lazy.nvim and are never stored in the Nix store.
{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = false;
    withRuby = false;

    viAlias = true;
    vimAlias = true;

    # System-level runtime dependencies (LSP servers, search backends, etc.)
    # Add language servers here as you enable them in your Neovim config.
    extraPackages = with pkgs; [
      ripgrep # required by telescope.nvim / fzf-lua for live grep
      fd # fast file finder used by telescope.nvim
    ];
  };
}
