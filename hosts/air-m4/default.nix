# MacBook Air (M 系列) 主机入口
# 组合各模块，设置主机特有选项
{
  inputs,
  self,
  username,
  hostname,
  ...
}:
{
  imports = [
    ./hardware.nix
    ../../modules/common/nix.nix
    ../../modules/darwin/packages.nix
    ../../modules/darwin/system.nix
    ../../modules/darwin/homebrew.nix
  ];

  system.primaryUser = username;
  system.configurationRevision = self.rev or self.dirtyRev or null;
  nixpkgs.config.allowUnfree = true;

  # 国内镜像加速（Rust / Go）
  environment.variables = {
    RUSTUP_DIST_SERVER = "https://rsproxy.cn";
    RUSTUP_UPDATE_ROOT = "https://rsproxy.cn/rustup";
    GOPROXY = "https://goproxy.cn,direct";
  };

  # nix-homebrew 选项（模块由 flake.nix 注入）
  nix-homebrew = {
    enable = true;
    enableRosetta = true; # Apple Silicon: 同时安装 Intel 前缀
    user = username;
    autoMigrate = true;
  };

  # home-manager 选项（模块由 flake.nix 注入）
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs username hostname; };
    users.${username} = {
      imports = [
        ../../home
        ../../home/profiles/base.nix
        ../../home/profiles/dev.nix
        ../../home/profiles/desktop.nix
      ];
    };
  };
}
