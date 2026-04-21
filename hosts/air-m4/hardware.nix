# Platform and state version for MacBook Air (M-series).
{ ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
}
