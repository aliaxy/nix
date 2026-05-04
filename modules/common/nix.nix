# Common Nix settings shared across all platforms and hosts.
{ ... }:
{
  # Enable flakes and the unified CLI (nix-command)
  nix.settings.experimental-features = "nix-command flakes";

  # Allow unfree/proprietary packages project-wide
  nixpkgs.config.allowUnfree = true;
}
