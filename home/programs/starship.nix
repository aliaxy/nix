# Starship — cross-shell prompt configuration.
{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      # Don't print a blank line before each prompt.
      add_newline = false;

      # Increase timeouts to avoid false "command took too long" warnings
      # on network-mounted or slow filesystems.
      scan_timeout = 5000;
      command_timeout = 5000;

      # Show the time module on the right side of the prompt.
      right_format = lib.concatStrings [ "$time" ];

      time = {
        disabled = true; # Toggle to true to display the clock.
        format = "at [$time]($style)";
        use_12hr = true;
        time_format = "%Y-%m-%d %I:%M %p";
      };

      character = {
        success_symbol = "[[󰋑](green) ❯](maroon)";
        error_symbol = "[[󰋔](red) ❯](maroon)";
        vimcmd_symbol = "[❮](green)"; # Shown when shell is in vi normal mode.
      };

      directory = {
        # Show at most 4 path components before truncating.
        truncation_length = 4;
        style = "bold lavender";
      };

      username = {
        show_always = true;
        format = "[$user]($style)@";
        style_user = "bold blue";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style) ";
        style = "bold teal";
      };

      nix_shell = {
        heuristic = true;
      };
    };
  };
}
