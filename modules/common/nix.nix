# Nix daemon / Core settings (Cross-platform common)
{ ... }:
{
  nix.settings.experimental-features = "nix-command flakes";

  # Allow installation of unfree/proprietary packages globally
  nixpkgs.config.allowUnfree = true;
}
