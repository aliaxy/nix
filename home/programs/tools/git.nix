# Git 版本控制
{ ... }:
{
  programs.git = {
    enable = true;
    settings.user.name = "aliaxy";
    settings.user.email = "aruvelut00@163.com";
    settings.init.defaultBranch = "main";
  };
}
