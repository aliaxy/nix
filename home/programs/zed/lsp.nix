{
  clangd = {
    initialization_options = {
      # Default to C++23 for files without a compile_commands.json.
      fallbackFlags = ["-std=c++23"];
    };
  };

  gopls = {
    initialization_options = {
      gofumpt = true;
    };
  };

  golangci-lint = {
    initialization_options = {
      command = [
        "golangci-lint"
        "run"
        "--enable"
        "revive"
        "--output.json.path"
        "stdout"
        "--show-stats=false"
        "--output.text.path="
      ];
    };
  };
}
