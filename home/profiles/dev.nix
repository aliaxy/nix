# Development profile — VCS, language toolchains, and package mirrors.
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
    nixd
    fnm
    rustup
  ];

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
  };

  programs.go = {
    enable = true;
    env = {
      GOPATH = "${config.home.homeDirectory}/go";
      GOBIN = "${config.home.homeDirectory}/go/bin";
    };
  };

  # PyPI mirror via Tsinghua TUNA for faster package downloads in China.
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

  programs.codex.enable = true;
  programs.claude-code.enable = true;

  # Cargo/Rustup mirror via rsproxy for faster downloads in China.
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

  # Rust and Go registry mirrors for faster resolution in China.
  home.sessionVariables = {
    RUSTUP_DIST_SERVER = "https://rsproxy.cn";
    RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup";
    GOPROXY = "https://goproxy.cn,direct";
  };
}
