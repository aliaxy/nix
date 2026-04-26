# Nix System Configuration

A modular, flake-based Nix configuration for managing macOS via `nix-darwin` with Home Manager integration. It separates system-level host configuration from user-level application setup.

## 📂 Repository Structure

The configuration is organized into a clean, layered architecture to maximize reusability across different machines and operating systems:

- **`flake.nix`**: The main entry point. It defines inputs and exports host configurations using custom builder functions.
- **`lib/`**: Contains the custom `mkDarwinSystem` helper used to assemble host configurations.
- **`hosts/`**: Machine-specific configurations. Each folder represents one host, such as `air-m4`.
- **`modules/`**: System-level configurations (root/admin level).
  - `common/`: Cross-platform OS settings (e.g., enabling Nix flakes).
  - `darwin/`: macOS-specific settings (Homebrew, Dock, Finder, dscl shell configuration).
- **`home/`**: User-level configurations managed entirely by Home Manager.
  - `default.nix`: The entry point for Home Manager, importing profiles.
  - `profiles/`: Bundled "suites" of applications that can be imported per host.
    - `base.nix`: Core CLI utilities (Fish, Starship, eza, bat, zoxide, fastfetch, yazi).
    - `dev.nix`: Development environment (Git, Go, SSH, uv, Rustup, AI tools).
    - `desktop.nix`: GUI applications and window managers (Ghostty, Zed, AeroSpace).
  - `programs/`: Complex, single-app configurations extracted for better readability.
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
*Note: Once the configuration is applied, if you use the default `fish` shell, you can simply type `drb` to quickly rebuild and switch the system.*

## 🛠️ Architecture Highlights

- **Opt-in Profiles**: Instead of forcing all packages on every machine, user environments are composed using profiles. A headless Linux server can simply import `base.nix` and `dev.nix`, completely ignoring macOS GUI tools.
- **Dynamic Variables**: `hostname` and `username` are passed down through the module system via `specialArgs`, avoiding hardcoded paths and making the setup adaptable for new Darwin hosts.
- **Declarative Everything**: 
  - Mac apps and casks are managed via `nix-homebrew`.
  - System preferences are managed via `nix-darwin`.
  - Dev tools, CLI apps, and dotfiles are managed via `home-manager` native programs (e.g., `programs.uv`, `programs.go`).
