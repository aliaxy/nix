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
    };
  };

  # Dedicated conf.d file for loading agenix-decrypted secrets.
  # Kept separate from fish.nix so that adding a new secret only requires
  # a new age.secrets declaration in the host config and a new entry here —
  # the rest of the fish configuration stays untouched.
  xdg.configFile."fish/conf.d/secrets.fish".text = ''
    # Load agenix-decrypted secrets into the environment.
    # Each block corresponds to an age.secrets entry in the host config.
    # Secrets are only available after `darwin-rebuild switch` has run.

    if test -r /run/agenix/github_token
      set -gx GITHUB_TOKEN (cat /run/agenix/github_token)
    end
  '';
}
