# Go 语言工具链
{ ... }:
{
  programs.go = {
    enable = true;
    env = {
      GOPATH = "/Users/aliaxy/go";
      GOBIN = "/Users/aliaxy/go/bin";
    };
  };
}
