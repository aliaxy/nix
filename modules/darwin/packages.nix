# macOS system-level packages, shells, and fonts
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mas
    keka
    ghostty-bin
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # Let nix-darwin manage fish (register to /etc/shells, etc.)
  programs.fish.enable = true;

  environment.shells = [ pkgs.fish ];

}
