# modules/darwin/system.nix — macOS system preferences
#
# Defines my.darwin.* options for timezone, Dock, and user settings.
# Wires them into nix-darwin's system.defaults and networking.
{
  config,
  lib,
  pkgs,
  username,
  self,
  ...
}:
let
  inherit (lib) mkOption types;
  cfg = config.my.darwin;
in
{
  options.my.darwin = {
    timeZone = mkOption {
      type = types.str;
      default = "Asia/Shanghai";
      description = "System time zone.";
      example = "America/New_York";
    };

    dock = {
      position = mkOption {
        type = types.enum [
          "bottom"
          "left"
          "right"
        ];
        default = "bottom";
        description = "Edge of the screen where the Dock appears.";
      };

      tileSize = mkOption {
        type = types.int;
        default = 64;
        description = "Dock icon size in pixels.";
      };

      extraPersistentApps = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "Host-specific app paths appended to the shared Dock entries.";
      };
    };
  };

  config = {
    users.users.${username} = {
      home = "/Users/${username}";
      shell = pkgs.fish;
    };

    time.timeZone = cfg.timeZone;

    # Required by nix-darwin for multi-user setups.
    system.primaryUser = username;

    # Expose the flake revision in `darwin-version --json`.
    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Set fish as the login shell via dscl, since nix-darwin does not do this
    # automatically when the shell binary lives outside /etc/shells defaults.
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
        FXPreferredViewStyle = "clmv"; # Column view
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
        # Disable hot corners.
        wvous-tr-corner = 1;
        wvous-tl-corner = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
      };

      NSGlobalDomain = {
        # Allow dragging windows by holding anywhere on the title bar.
        NSWindowShouldDragOnGesture = true;
        # Disable window open/close animations for snappier feel.
        NSAutomaticWindowAnimationsEnabled = false;
      };
    };
  };
}
