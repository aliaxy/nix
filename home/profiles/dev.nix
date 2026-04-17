# dev profile — 开发环境：版本控制、语言工具链、国内镜像
{ ... }:
{
  imports = [
    ../programs/tools/git.nix
    ../programs/tools/ssh.nix
    ../programs/tools/go.nix
    ../programs/tools/ai.nix
  ];

  # Rust 国内镜像（rsproxy）
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

  # Python uv 国内镜像（清华 TUNA）
  home.file.".config/uv/uv.toml".text = ''
    [[index]]
    url = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple/"
    default = true
  '';
}
