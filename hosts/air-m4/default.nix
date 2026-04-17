# MacBook Air (M-series) host entry point
# Combine modules and set host-specific options
{
  inputs,
  self,
  username,
  hostname,
  ...
}:
{
  imports = [
    # Hardware-specific configuration (e.g., platform, state version)
    ./hardware.nix
    # Cross-platform common Nix settings
    ../../modules/common/nix.nix
    # macOS system-level packages and default shell
    ../../modules/darwin/packages.nix
    # macOS system preferences (Dock, Finder, Users)
    ../../modules/darwin/system.nix
    # Homebrew management via nix-darwin
    ../../modules/darwin/homebrew.nix
  ];

  # Define the primary user for the macOS system
  system.primaryUser = username;
  # Track the current flake revision for darwin-version
  system.configurationRevision = self.rev or self.dirtyRev or null;
  # Allow installation of unfree/proprietary packages
  nixpkgs.config.allowUnfree = true;

  # Domestic mirrors acceleration (Rust / Go)
  environment.variables = {
    RUSTUP_DIST_SERVER = "https://rsproxy.cn";
    RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup";
    GOPROXY = "https://goproxy.cn,direct";
  };

  # nix-homebrew options (module injected by flake.nix)
  nix-homebrew = {
    enable = true;
    enableRosetta = true; # Apple Silicon: Install Intel prefix concurrently for Rosetta
    user = username;
    autoMigrate = true;
  };

  # home-manager options (module injected by flake.nix)
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs username hostname; };
    users.${username} = {
      imports = [
        # Main home-manager entry point
        ../../home
        # Essential CLI tools and shell environments
        ../../home/profiles/base.nix
        # Developer toolchain and configurations
        ../../home/profiles/dev.nix
        # GUI applications and window manager
        ../../home/profiles/desktop.nix
      ];
    };
  };
}
