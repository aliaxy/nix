# Nix System Configuration

A modular, flake-based Nix configuration for managing macOS via `nix-darwin`, Home Manager, `nix-homebrew`, and reusable project dev-shell templates. It separates system-level host configuration from user-level application setup.

## 📂 Repository Structure

The configuration is organized into a clean, layered architecture to maximize reusability across different machines and operating systems:

- **`flake.nix`**: The main entry point. It defines inputs, exports Darwin host configurations, and exposes project templates.
- **`lib/`**: Contains the custom `mkDarwinSystem` helper used to assemble host configurations.
- **`hosts/`**: Machine-specific configurations. Each folder represents one host, such as `air-m4`.
- **`modules/`**: System-level configurations (root/admin level).
  - `common/`: Cross-platform OS settings (e.g., enabling Nix flakes).
  - `darwin/`: macOS-specific settings (Homebrew, app suites, Dock, Finder, shell activation, system defaults).
- **`home/`**: User-level configurations managed entirely by Home Manager.
  - `default.nix`: The entry point for Home Manager, importing profiles.
  - `profiles/`: Bundled "suites" of applications that can be imported per host.
    - `base.nix`: Core CLI utilities (Fish, Starship, eza, bat, zoxide, fastfetch, yazi).
    - `dev.nix`: Development environment (Git, GitHub CLI, SSH, direnv, Nix language servers, AI tools, OpenSpec).
    - `mirrors.nix`: Language and package-manager mirror settings.
  - `programs/`: Complex, single-app configurations extracted for better readability.
- **`templates/`**: Per-project dev-shell templates for C/C++, Go, Node.js, Python, and Rust.
- `catppuccin.nix`: Centralized theme settings shared across supported Home Manager programs.

## 🚀 Getting Started

### Prerequisites
- Install [Nix](https://nixos.org/download.html)
- Enable experimental features (`nix-command` and `flakes`)

### Apply Configuration (macOS)
To build and switch to the `air-m4` configuration for the first time:
```bash
nix run nix-darwin -- switch --flake .#air-m4
```

After `nix-darwin` is installed, rebuild the active host with:
```bash
darwin-rebuild switch --flake .#air-m4
```

When the managed `fish` shell is active, `drb` is a shortcut for rebuilding and switching the current Darwin host. Additional shortcuts include `nfu` (`nix flake update`), `nfl` (`nix flake lock`), and `nfc` (`nix flake check`).

## 🛠️ Architecture Highlights

- **Opt-in Profiles**: Instead of forcing all packages on every machine, user environments are composed using profiles. A headless Linux server can simply import `base.nix` and `dev.nix`, completely ignoring macOS GUI tools.
- **Dynamic Variables**: `hostname` and `username` are passed down through the module system via `specialArgs`, avoiding hardcoded paths and making the setup adaptable for new Darwin hosts.
- **Declarative Everything**:
  - Mac apps and casks are managed via `nix-homebrew`.
  - System preferences are managed via `nix-darwin`.
  - Dev tools, CLI apps, editor settings, and dotfiles are managed via `home-manager` native programs.
  - Project language toolchains are provided through per-project flake templates instead of the global user profile.
- **Templates over global toolchains**: Project templates provide focused shells for C/C++, Go, Node.js, Python, and Rust. The Go template includes protobuf/gRPC tooling, Node.js tracks the default `nodejs` package from `nixpkgs`, and Python uses `uv`, `ruff`, and `pyright`.
