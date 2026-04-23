# MacBook Air M-series — host-specific configuration.
# All shared modules are loaded by mkDarwinSystem in lib/; only values that
# differ per machine belong here.
{ ... }:
{
  imports = [
    # Platform identity and nix-darwin state version
    ./hardware.nix
  ];

  # Decrypt secrets at activation time using the user's SSH key.
  age.identityPaths = [ "/Users/aliaxy/.ssh/id_ed25519_github" ];

  age.secrets.github_token = {
    file = ../../secrets/github_token.age;
    owner = "aliaxy";
  };

  # Host-specific option values.
  # These are merged with the reusable base lists defined in the darwin modules.
  my = {
    darwin = {
      roles = {
        essentials = true;
        development = true;
        productivity = true;
        communication = true;
        office = true;
        iWork = true;
      };

      dock.extraPersistentApps = [
        "/System/Applications/Reminders.app"
        "/System/Applications/iPhone Mirroring.app"
        "/Applications/Ghostty.app"
        "/Applications/Google Chrome.app"
        "/Applications/Notion.app"
        "/Applications/Sublime Text.app"
        "/Applications/Zed.app"
        "/Applications/Orbstack.app"
        "/Applications/App Cleaner 9.app"
      ];

      homebrew = {
        enableRosetta = true; # Apple Silicon: install the Intel prefix for Rosetta 2
        nonGreedyCasks = [
          "microsoft-word"
          "microsoft-excel"
          "microsoft-powerpoint"
        ];
      };
    };
  };

  # Opt-in Home Manager profiles for this host
  my.home.profiles = {
    base = true;
    dev = true;
    desktop = true;
  };
}
