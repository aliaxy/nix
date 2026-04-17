# dev profile - development environment: VCS, toolchains, mirrors
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    rustup
  ];

  programs.git = {
    enable = true;
    settings.user.name = "aliaxy";
    settings.user.email = "aruvelut00@163.com";
    settings.init.defaultBranch = "main";
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

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  programs.go = {
    enable = true;
    env = {
      GOPATH = "${config.home.homeDirectory}/go";
      GOBIN = "${config.home.homeDirectory}/go/bin";
    };
  };

  # Python uv domestic mirror (Tsinghua TUNA)
  programs.uv = {
    enable = true;
    settings = {
      index = [
        {
          url = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple/";
          default = true;
        }
      ];
    };
  };

  # AI coding assistants
  programs.codex.enable = true;
  programs.claude-code.enable = true;

  # Rust domestic mirror (rsproxy)
  home.file.".cargo/config.toml".text = ''
    [source.crates-io]
    replace-with = 'rsproxy-sparse'
    [source.rsproxy]
    registry = "https://rsproxy.cn/crates.io-index"
    [source.rsproxy-sparse]
    registry = "sparse+https://rsproxy.cn/index/"
    [registries.rsproxy]
    index = "https://rsproxy.cn/crates.io-index"
    [net]
    git-fetch-with-cli = true
  '';

}
