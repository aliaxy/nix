# Fish shell: interactive init, aliases, and host-specific functions
{
  hostname,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # suppress the default greeting

      # Interactive brew only. darwin-rebuild activation does not see this;
      # keep a token in ~/.homebrew/brew.env for private taps during rebuild.
      if not set -q HOMEBREW_GITHUB_API_TOKEN; and type -q gh
        set -l homebrew_github_api_token (gh auth token 2>/dev/null)
        if test -n "$homebrew_github_api_token"
          set -gx HOMEBREW_GITHUB_API_TOKEN $homebrew_github_api_token
        end
      end
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
      nfu = "nix flake update";
      nfl = "nix flake lock";
      nfc = "nix flake check";
      da = "direnv allow";
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
          echo "use flake" > .envrc
        '';
      };
    };

    plugins = [
      {
        name = "fish-completion-sync";
        src = pkgs.fetchFromGitHub {
          owner = "pfgray";
          repo = "fish-completion-sync";
          rev = "ba70b6457228af520751eab48430b1b995e3e0e2";
          sha256 = "sha256-JdOLsZZ1VFRv7zA2i/QEZ1eovOym/Wccn0SJyhiP9hI=";
        };
      }
    ];
  };
}
