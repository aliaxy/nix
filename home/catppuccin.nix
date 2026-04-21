# Centralized Catppuccin theme settings for Home Manager programs.
# All programs share the same flavor; file-related tools use lavender as the accent.
#
# Available flavors : latte | frappe | macchiato | mocha
# Available accents : blue | flamingo | green | lavender | maroon | mauve |
#                     peach | pink | red | rosewater | sapphire | sky | teal | yellow
{ ... }:
let
  base = {
    enable = true;
    flavor = "macchiato";
  };
in
{
  catppuccin = {
    bat = base;
    lazygit = base;
    ghostty = base;
    starship = base;
    eza = base // {
      accent = "lavender";
    };
    yazi = base // {
      accent = "lavender";
    };
    zed = base // {
      icons = base;
    };
  };
}
