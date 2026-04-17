# desktop profile - GUI environment exclusive: terminal, editor, window manager
{ ... }:
{
  imports = [
    ../programs/ghostty.nix
    ../programs/zed.nix
    ../programs/aerospace.nix
  ];
}
