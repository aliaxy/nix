# Zed editor — managed by Home Manager, installed via Homebrew cask.
{ ... }:
{
  programs.zed-editor = {
    enable = true;
    package = null; # installed via Homebrew cask, not Nix

    extensions = import ./extensions.nix;
    userSettings = import ./settings.nix;
  };
}
