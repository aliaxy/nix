# Development profile — VCS and tooling.
# Language toolchains (go, python, rust) are managed per-project via nix-direnv.
# Network mirrors are in mirrors.nix.
{ pkgs, ... }:
{
  imports = [
    ./mirrors.nix
    ./sops.nix
    ../programs/zed.nix
  ];

  home.packages = with pkgs; [
    nil
    nixd
    nodejs
    openspec
  ];

  home.sessionVariables = {
    OPENSPEC_TELEMETRY = 0;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
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
}
