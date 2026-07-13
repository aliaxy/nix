# System-level fonts and shell registration for macOS hosts.
# User CLIs belong in home/default.nix or profiles, not here.
{pkgs, ...}: {
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # Register fish so nix-darwin adds it to /etc/shells.
  programs.fish.enable = true;
  environment.shells = [pkgs.fish];
}
