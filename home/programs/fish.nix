# Fish shell: interactive init, aliases, and host-specific functions
{ hostname, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # suppress the default greeting
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
        description = "Rebuild and switch the ${hostname} nix-darwin configuration";
        body = "sudo darwin-rebuild switch --flake ~/nix#${hostname}";
      };

      mkdev = {
        description = "Init a nix dev shell template and wire up direnv";
        body = ''
          if test (count $argv) -eq 0
              echo "Usage: mkdev <lang>"
              echo "Available: go rust python node c"
              return 1
          end
          nix flake init -t ~/nix#$argv[1]; or return 1
          echo "use flake" > .envrc; or return 1
          direnv allow; or return 1
        '';
      };
    };
  };
}
