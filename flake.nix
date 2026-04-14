{
  description = "aliaxy nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
      #catppuccin,
    }:
  let
    configuration = { pkgs, ... }: {
      system.primaryUser = "aliaxy";
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = with pkgs; [
        neovim
	ghostty-bin
	fish
	starship
	keka
	eza
	uv
	rustup
	go
	fnm
      ];

      homebrew = {
        enable = true;
	onActivation = {
	  autoUpdate = true;
	  upgrade = true;
	  cleanup = "zap";
	};
	greedyCasks = true;

	brews = [
	];

	casks = [
	  "orbstack"
	  "qq"
	  "wechat"
	  "wechatwork"
	  "google-chrome"
	  "zed"
	  "notion"
	  "typora"
	  "sublime-text"
	  "clash-verge-rev"
	  "app-cleaner"
	  "feishu"
	  "sf-symbols"
	  "font-sf-pro"
	  "font-sf-mono"
	  "microsoft-word"
	  "microsoft-excel"
	  "microsoft-powerpoint"
	];
      };

      environment.shells = [
      	pkgs.fish
      ];

      fonts.packages = [
      	pkgs.nerd-fonts.jetbrains-mono
      ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      users.users."aliaxy" = {
        home = "/Users/aliaxy";
      	shell = pkgs.fish;
      };

      system.activationScripts.setDefaultShell.text = ''
        fish=/run/current-system/sw/bin/fish
    	current=$(dscl . -read /Users/aliaxy UserShell 2>/dev/null | awk '{print $2}')
    	if [ "$current" != "$fish" ]; then
      	  echo "Setting default shell for aliaxy to fish"
      	  dscl . -create /Users/aliaxy UserShell "$fish"
    	fi
      '';

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      system.defaults.dock = {
        autohide = true;

	persistent-apps = [
	  "/System/Applications/System Settings.app"
          "/System/Applications/Messages.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Reminders.app"
          "/System/Applications/iPhone Mirroring.app"
          "/Applications/Nix Apps/Ghostty.app"
          "/Applications/Google Chrome.app"
	  "/Applications/Notion.app"
          "/Applications/Sublime Text.app"
          "/Applications/Zed.app"
	  "/Applications/Orbstack.app"
          "/Applications/App Cleaner 9.app"
	];
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#air
    darwinConfigurations."air" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
	nix-homebrew.darwinModules.nix-homebrew
	{
	  nix-homebrew = {
	    # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = "aliaxy";

	    autoMigrate = true;
	  };
	}
	home-manager.darwinModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.aliaxy = { ... }: {
            home.stateVersion = "25.11";

            programs.git = {
              enable = true;
              settings.user.name = "aliaxy";
              settings.user.email = "aruvelut00@163.com";
              settings.init.defaultBranch = "main";
            };
          };
	}
      ];
    };
  };
}
