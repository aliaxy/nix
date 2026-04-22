# System-level packages, fonts, and shell registration for macOS hosts.
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mas # Mac App Store CLI
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # Register fish so nix-darwin adds it to /etc/shells.
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
}
