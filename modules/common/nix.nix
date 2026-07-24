# Common Nix settings shared across all platforms and hosts.
_: {
  # Enable flakes and the unified CLI (nix-command)
  nix.settings.experimental-features = "nix-command flakes";

  # Use devenv's public binary cache for its prebuilt dependencies.
  nix.settings = {
    extra-trusted-users = [
      "aliaxy"
    ];
    extra-substituters = [
      "https://devenv.cachix.org"
      "https://nixpkgs-python.cachix.org"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
    ];
  };

  # Allow unfree/proprietary packages project-wide
  nixpkgs.config.allowUnfree = true;
}
