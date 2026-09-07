# Centralized Catppuccin theme settings for Home Manager programs.
# All programs share the same flavor and lavender accent.
# Neovim is excluded: lazy.nvim already vendors catppuccin/nvim.
#
# Available flavors : latte | frappe | macchiato | mocha
# Available accents : blue | flamingo | green | lavender | maroon | mauve |
#                     peach | pink | red | rosewater | sapphire | sky | teal | yellow
_: {
  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "macchiato";
    accent = "lavender";
    nvim.enable = false;
  };
}
