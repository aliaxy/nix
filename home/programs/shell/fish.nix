# Fish shell 配置
{ ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # 禁用欢迎信息
      fnm env --use-on-cd --shell fish | source
    '';

    shellAliases = {
      ls = "eza";
      la = "ls -a";
      ll = "ls -lh";
      lla = "ll -a";
      lg = "lla --git";
      tree = "ls -T";
      rmi = "rm -i";
      cat = "bat";
      jy = "fastfetch";
      ngc = "nix-collect-garbage -d";
    };

    functions = {
      drb = {
        description = "Rebuild Darwin with the air flake";
        body = "sudo darwin-rebuild switch --flake ~/nix#air";
      };
    };
  };
}
