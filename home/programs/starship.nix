# Starship - cross-shell prompt
{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      scan_timeout = 5000;
      command_timeout = 5000;

      right_format = lib.concatStrings [ "$time" ];

      time = {
        disabled = true;
        format = "at [$time]($style)";
        use_12hr = true;
        time_format = "%Y-%m-%d %I:%M %p";
      };

      character = {
        success_symbol = "[[󰋑](green) ❯](maroon)";
        error_symbol = "[[󰋔](red) ❯](maroon)";
        vimcmd_symbol = "[❮](green)";
      };

      directory = {
        truncation_length = 4;
        style = "bold lavender";
      };
    };
  };
}
