# Nix System Configuration

A highly modular, flake-based Nix configuration for managing macOS (via `nix-darwin`) and Linux/NixOS systems. It strictly separates system-level hardware/OS configurations from user-level application setups (via `home-manager`).

## 📂 Repository Structure

The configuration is organized into a clean, layered architecture to maximize reusability across different machines and operating systems:

- **`flake.nix`**: The main entry point. It defines inputs and exports host configurations using custom builder functions.
- **`lib/`**: Contains custom helper functions like `mkDarwinSystem` and `mkNixosSystem` to abstract away boilerplate when defining new hosts.
- **`hosts/`**: Machine-specific configurations (e.g., `air-m4`, `nixos-desktop`, `wsl`). Each folder represents a unique physical or virtual machine.
- **`modules/`**: System-level configurations (root/admin level).
  - `common/`: Cross-platform OS settings (e.g., enabling Nix flakes).
  - `darwin/`: macOS-specific settings (Homebrew, Dock, Finder, dscl shell configuration).
  - `nixos/`: Linux/NixOS-specific settings (Bootloader, Networking, Desktop Environments).
- **`home/`**: User-level configurations managed entirely by Home Manager.
  - `default.nix`: The entry point for Home Manager, importing profiles.
  - `profiles/`: Bundled "suites" of applications that can be imported per host.
    - `base.nix`: Core CLI utilities (Fish, Starship, eza, bat, zoxide, fastfetch, yazi).
    - `dev.nix`: Development environment (Git, Go, SSH, uv, Rustup, AI tools).
    - `desktop.nix`: GUI applications and window managers (Ghostty, Zed, AeroSpace).
  - `programs/`: Complex, single-app configurations extracted for better readability.
- **`themes/`**: Centralized theming variables (e.g., Catppuccin flavor and accent) shared across multiple applications.

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
- **Dynamic Variables**: `hostname` and `username` are passed down through the module system via `specialArgs`, avoiding hardcoded paths and making the setup easily adaptable for new machines or users.
- **Declarative Everything**: 
  - Mac apps and casks are managed via `nix-homebrew`.
  - System preferences are managed via `nix-darwin`.
  - Dev tools, CLI apps, and dotfiles are managed via `home-manager` native programs (e.g., `programs.uv`, `programs.go`).