# Yazi — terminal file manager with shell integration and plugin support.
{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    # Wrap yazi with a shell function named `y` that automatically changes the
    # working directory of the parent shell when yazi exits.
    shellWrapperName = "y";

    settings = {
      mgr = {
        # Panel width ratio: parent | current | preview
        ratio = [
          1
          2
          4
        ];
        show_hidden = true;
      };
    };

    keymap.mgr.prepend_keymap = [
      {
        on = "<Enter>";
        run = "plugin smart-enter";
        desc = "Enter the child directory, or open the file";
      }
    ];

    plugins = {
      # smart-enter: enters a directory on <Enter> if the hovered item is a
      # directory, otherwise opens the file with the default opener.
      smart-enter = pkgs.yaziPlugins.smart-enter;
      starship = pkgs.yaziPlugins.starship;
    };

    initLua = ''
      require("starship"):setup()
    '';
  };
}
