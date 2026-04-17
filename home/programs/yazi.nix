# Yazi - terminal file manager
{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    settings = {
      mgr = {
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
      smart-enter = pkgs.yaziPlugins.smart-enter;
    };
  };
}
