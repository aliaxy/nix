# AeroSpace tiling window manager + JankyBorders focus-aware window borders.
# AeroSpace is installed via Homebrew cask; launchd integration is disabled
# because AeroSpace manages its own login-item registration.
{ ... }:
{
  programs.aerospace = {
    enable = true;
    launchd.enable = false;
    package = null; # installed via Homebrew cask, not Nix

    settings = {
      config-version = 2;

      after-login-command = [ ];
      after-startup-command = [ ];
      start-at-login = false;

      # Normalisation keeps the workspace tree tidy by collapsing redundant
      # container nesting automatically.
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      # Warp the mouse to the centre of the newly focused monitor.
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      automatically-unhide-macos-hidden-apps = false;

      # Named workspaces: 1-9 for general use, lettered for pinned apps.
      persistent-workspaces = [
        "1"
        "2"
        "3"
        "4"
        "5"
        "6"
        "7"
        "8"
        "9"
        "10"
      ];

      on-mode-changed = [ ];

      key-mapping.preset = "qwerty";

      # ── Gaps ────────────────────────────────────────────────────────────────
      gaps = {
        inner.horizontal = 10;
        inner.vertical = 10;
        outer.left = 8;
        outer.bottom = 8;
        outer.top = 8;
        outer.right = 8;
      };

      mode.main.binding = {
        # ── Layout ────────────────────────────────────────────────────────────
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";
        alt-backslash = "layout floating tiling";

        # ── Focus (vi-style) ──────────────────────────────────────────────────
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        # ── Move window ───────────────────────────────────────────────────────
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # ── Resize ────────────────────────────────────────────────────────────
        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        # ── App shortcuts (switch workspace + launch if not running) ──────────
        alt-enter = [
          "workspace 1"
          "exec-and-forget open -a Ghostty"
        ];
        alt-c = [
          "workspace 2"
          "exec-and-forget open -a 'Google Chrome'"
        ];

        alt-a = "exec-and-forget open -a 'Activity Monitor'";
        alt-f = "exec-and-forget open -a Finder";
        alt-s = "exec-and-forget open -a 'System Settings'";
        alt-z = "exec-and-forget open -a Zed";

        # ── Workspace switch (numeric) ────────────────────────────────────────
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-7 = "workspace 7";
        alt-8 = "workspace 8";
        alt-9 = "workspace 9";

        # ── Workspace switch (lettered, pinned apps) ──────────────────────────
        alt-q = [
          "workspace Q"
          "exec-and-forget open -a QQ"
        ];
        alt-w = [
          "workspace W"
          "exec-and-forget open -a Wechat"
        ];
        alt-e = [
          "workspace E"
          "exec-and-forget open -a Feishu"
        ];
        alt-u = [
          "workspace U"
          "exec-and-forget open -a 'App Cleaner 9'"
        ];
        alt-i = [
          "workspace I"
          "exec-and-forget open -a 'Microsoft Word'"
        ];
        alt-o = [
          "workspace O"
          "exec-and-forget open -a 'Microsoft Excel'"
        ];
        alt-p = [
          "workspace P"
          "exec-and-forget open -a 'Microsoft PowerPoint'"
        ];
        alt-v = [
          "workspace V"
          "exec-and-forget open -a 'Clash Verge'"
        ];

        # ── Move window to workspace (numeric) ────────────────────────────────
        alt-shift-1 = [
          "move-node-to-workspace 1"
          "workspace 1"
        ];
        alt-shift-2 = [
          "move-node-to-workspace 2"
          "workspace 2"
        ];
        alt-shift-3 = [
          "move-node-to-workspace 3"
          "workspace 3"
        ];
        alt-shift-4 = [
          "move-node-to-workspace 4"
          "workspace 4"
        ];
        alt-shift-5 = [
          "move-node-to-workspace 5"
          "workspace 5"
        ];
        alt-shift-6 = [
          "move-node-to-workspace 6"
          "workspace 6"
        ];
        alt-shift-7 = [
          "move-node-to-workspace 7"
          "workspace 7"
        ];
        alt-shift-8 = [
          "move-node-to-workspace 8"
          "workspace 8"
        ];
        alt-shift-9 = [
          "move-node-to-workspace 9"
          "workspace 9"
        ];

        # ── Move window to workspace (lettered) ───────────────────────────────
        alt-shift-q = [
          "move-node-to-workspace Q"
          "workspace Q"
        ];
        alt-shift-w = [
          "move-node-to-workspace W"
          "workspace W"
        ];
        alt-shift-e = [
          "move-node-to-workspace E"
          "workspace E"
        ];
        alt-shift-u = [
          "move-node-to-workspace U"
          "workspace U"
        ];
        alt-shift-i = [
          "move-node-to-workspace I"
          "workspace I"
        ];
        alt-shift-o = [
          "move-node-to-workspace O"
          "workspace O"
        ];
        alt-shift-p = [
          "move-node-to-workspace P"
          "workspace P"
        ];
        alt-shift-a = [
          "move-node-to-workspace A"
          "workspace A"
        ];
        alt-shift-v = [
          "move-node-to-workspace V"
          "workspace V"
        ];

        # ── Window controls ───────────────────────────────────────────────────
        alt-shift-f = "fullscreen";
        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        # Enter service mode for advanced operations.
        alt-shift-semicolon = "mode service";

        # Suppress macOS default hide-window shortcuts to avoid conflicts.
        cmd-h = [ ];
        cmd-alt-h = [ ];
      };

      # ── Service mode ────────────────────────────────────────────────────────
      # Accessible via alt-shift-; — used for infrequent tree operations.
      mode.service.binding = {
        esc = [
          "reload-config"
          "mode main"
        ];
        r = [
          "flatten-workspace-tree"
          "mode main"
        ];
        f = [
          "layout floating tiling"
          "mode main"
        ];
        backspace = [
          "close-all-windows-but-current"
          "mode main"
        ];

        alt-shift-h = [
          "join-with left"
          "mode main"
        ];
        alt-shift-j = [
          "join-with down"
          "mode main"
        ];
        alt-shift-k = [
          "join-with up"
          "mode main"
        ];
        alt-shift-l = [
          "join-with right"
          "mode main"
        ];
      };

      # ── Window rules ────────────────────────────────────────────────────────
      # Force specific apps into floating layout; they don't benefit from tiling.
      on-window-detected = [
        {
          "if".app-id = "com.apple.finder";
          run = [ "layout floating" ];
        }
        {
          "if".app-id = "com.apple.systempreferences";
          run = [ "layout floating" ];
        }
        {
          "if".app-id = "com.apple.ActivityMonitor";
          run = [ "layout floating" ];
        }
        {
          "if".app-id = "com.tencent.qq";
          run = [ "layout floating" ];
        }
        {
          "if".app-id = "com.tencent.xinWeChat";
          run = [ "layout floating" ];
        }
        {
          "if".app-id = "com.tencent.WeWorkMac";
          run = [ "layout floating" ];
        }
      ];
    };
  };

  # ── JankyBorders ────────────────────────────────────────────────────────────
  # Draws rounded, coloured borders around windows to indicate focus state.
  # Colours are Catppuccin Macchiato: lavender (active) / surface1 (inactive).
  services.jankyborders = {
    enable = true;
    settings = {
      style = "round";
      width = 6.0;
      blur_radius = 12.0;
      active_color = "0xffb7bdf8"; # lavender
      inactive_color = "0xff6e738d"; # surface1
      background_color = "0x00000000"; # transparent
    };
  };
}
