# macOS system preferences: user, shell, Finder, Dock
{
  config,
  lib,
  pkgs,
  username,
  hostname,
  self,
  ...
}:
let
  inherit (lib) mkOption types;
  cfg = config.my.darwin;
in
{
  options.my.darwin = {
    hostname = mkOption {
      type = types.str;
      default = hostname;
      description = "The host name to apply to this macOS machine.";
    };

    timeZone = mkOption {
      type = types.str;
      description = "The time zone to apply to this macOS machine.";
      example = "Asia/Shanghai";
    };

    dock = {
      position = mkOption {
        type = types.enum [
          "bottom"
          "left"
          "right"
        ];
        default = "bottom";
        description = "Dock screen edge.";
      };

      tileSize = mkOption {
        type = types.int;
        default = 48;
        description = "Dock icon size.";
      };

      extraPersistentApps = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Host-specific apps appended to the shared Dock entries.";
      };
    };

  };

  config = {
    users.users.${username} = {
      home = "/Users/${username}";
      shell = pkgs.fish;
    };

    networking.hostName = cfg.hostname;
    time.timeZone = cfg.timeZone;

    # Define the primary user for the macOS system
    system.primaryUser = username;
    # Track the current flake revision for darwin-version
    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Ensure fish is set as the default shell (via dscl)
    system.activationScripts.setDefaultShell.text = ''
      fish=/run/current-system/sw/bin/fish
      current=$(dscl . -read /Users/${username} UserShell 2>/dev/null | awk '{print $2}')
      if [ "$current" != "$fish" ]; then
        echo "Setting default shell for ${username} to fish"
        dscl . -create /Users/${username} UserShell "$fish"
      fi
    '';

    system.defaults = {
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "clmv";
      };
      dock = {
        autohide = true;
        orientation = cfg.dock.position;
        tilesize = cfg.dock.tileSize;
        persistent-apps = [
          "/System/Applications/System Settings.app"
          "/System/Applications/Messages.app"
          "/System/Applications/Mail.app"
        ]
        ++ cfg.dock.extraPersistentApps;
        wvous-tr-corner = 1;
        wvous-tl-corner = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
      };
      NSGlobalDomain = {
        NSWindowShouldDragOnGesture = true;
        NSAutomaticWindowAnimationsEnabled = false;
      };
    };
  };
}
