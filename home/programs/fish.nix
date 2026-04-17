# Fish shell configuration
{ hostname, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting message
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
        description = "Rebuild Darwin with the ${hostname} flake";
        body = "sudo darwin-rebuild switch --flake ~/nix#${hostname}";
      };
    };
  };
}
