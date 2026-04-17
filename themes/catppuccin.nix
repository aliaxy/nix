# Catppuccin 主题统一配置
# 在此集中管理 flavor 和 accent，各程序模块只需 import 本文件
# flavor 可选：latte | frappe | macchiato | mocha
# accent 可选：blue | flamingo | green | lavender | maroon | mauve | peach | pink | red | rosewater | sapphire | sky | teal | yellow
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
    ghostty = base;
    starship = base;
    eza = base // {
      accent = "lavender";
    };
    yazi = base // {
      accent = "lavender";
    };
  };
}
