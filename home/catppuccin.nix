# Catppuccin theme unified configuration
# Centralized management of flavor and accent, program modules only need to import this file
# flavor options:latte | frappe | macchiato | mocha
# accent options:blue | flamingo | green | lavender | maroon | mauve | peach | pink | red | rosewater | sapphire | sky | teal | yellow
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
