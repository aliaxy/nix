# Development profile — VCS and tooling.
# Language toolchains (go, python, rust) are managed per-project via nix-direnv.
# Network mirrors are in mirrors.nix.
{pkgs, ...}: {
  imports = [
    ./mirrors.nix
  ];

  home.packages = with pkgs; [
    nodejs
    nil
    nixd
    alejandra
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519_github";
      };
    };
  };

  programs.git = {
    enable = true;
    settings.user.name = "aliaxy";
    settings.user.email = "aruvelut00@163.com";
    settings.init.defaultBranch = "main";
  };

  programs.lazygit = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";
      editor = "nvim";

      aliases = {
        co = "pr checkout";
        pv = "pr view";
        pl = "pr list";
        il = "issue list";
        rv = "repo view";
      };
    };

    gitCredentialHelper = {
      enable = true;
      hosts = ["https://github.com"];
    };
  };

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;

    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };

  programs.codex.enable = true;
  programs.claude-code.enable = true;
  programs.antigravity-cli.enable = true;
}
