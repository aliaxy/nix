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

      # fix starship prompt to only have newlines after the first command
      # https://github.com/starship/starship/issues/560#issuecomment-2409922650
      function prompt_newline --on-event fish_postexec
      end

      function starship_transient_prompt_func
        tput cuu1
        starship module character
      end

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
        description = "Init a Prelude dev shell template (github:Sonatelle/prelude)";
        body = ''
          set -l tmpl default
          if test (count $argv) -gt 0
              set tmpl $argv[1]
          end
          # Templates ship their own .envrc; run `direnv allow` after init.
          nix flake init -t github:Sonatelle/prelude#$tmpl
        '';
      };
    };

    plugins = [
      {
        name = "fish-completion-sync";
        src = pkgs.fetchFromGitHub {
          owner = "iynaix";
          repo = "fish-completion-sync";
          rev = "4f058ad2986727a5f510e757bc82cbbfca4596f0";
          hash = "sha256-kHpdCQdYcpvi9EFM/uZXv93mZqlk1zCi2DRhWaDyK5g=";
        };
      }
    ];
  };
}
