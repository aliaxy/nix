# China mirror configurations — machine-level network settings, not project-specific.
# Language toolchains are managed per-project via nix-direnv; these mirrors
# apply globally so every devShell inherits them automatically.
{ ... }:
{
  # Go module proxy via goproxy.cn.
  home.sessionVariables = {
    GOPROXY = "https://goproxy.cn,direct";
  };

  # PyPI mirror via Tsinghua TUNA.
  xdg.configFile."uv/uv.toml".text = ''
    [[index]]
    url = "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple/"
    default = true
  '';

  # Cargo registry mirror via rsproxy.
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
