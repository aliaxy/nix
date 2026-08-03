# Zed editor — managed by Home Manager, installed via Homebrew cask.
#
# This file is a Home Manager module. The settings themselves live in
# settings.nix, which merges the per-domain files in this directory.
_: {
  programs.zed-editor = {
    enable = true;
    package = null; # installed via Homebrew cask, not Nix

    extensions = import ./extensions.nix;
    userSettings = import ./settings.nix;
  };
}
