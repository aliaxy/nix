# Repository Guidelines

## Project Structure & Module Organization
This repository is a flake-based Nix configuration for `nix-darwin` with Home Manager integration. `flake.nix` is the entry point and exports host configurations. `lib/default.nix` contains builders such as `mkDarwinSystem`. Put machine-specific overrides in `hosts/<hostname>/` and keep reusable system modules in `modules/common/` and `modules/darwin/`. User-level configuration lives in `home/`: `profiles/` groups opt-in app suites, and `programs/` holds larger per-app modules such as `fish.nix` and `zed.nix`. Encrypted secrets are declared in `secrets/`.

## Build, Test, and Development Commands
Use Nix commands from the repository root:

- `nix flake show` checks exported outputs and attribute names.
- `nix build .#darwinConfigurations.air-m4.system` builds the active macOS system closure without switching.
- `darwin-rebuild switch --flake .#air-m4` applies the `air-m4` host configuration.
- `nix eval .#darwinConfigurations.air-m4.config.my.darwin.timeZone --raw` is a quick way to validate option values during review.

If your shell is managed by this repo, `drb` is the shortcut for rebuilding the current Darwin host.

## Coding Style & Naming Conventions
Write Nix in the existing style: 2-space indentation, trailing semicolons, and one logical concern per file. Prefer small, composable modules over large host files. Use lowercase file names and descriptive module names such as `homebrew.nix` or `system.nix`. Keep comments brief and explain intent, not syntax. Follow the repository’s existing pattern of passing `hostname` and `username` through `specialArgs` instead of hardcoding paths.

## Testing Guidelines
There is no dedicated `tests/` directory. Treat evaluation and builds as the primary validation path: run `nix flake show`, build the affected configuration, and only switch after the build succeeds. For host-specific changes, verify the relevant options with `nix eval` before applying them.

## Commit & Pull Request Guidelines
Recent history follows Conventional Commit style: `feat: ...`, `refactor(flake): ...`, `chore(zed): ...`, `docs: ...`. Keep subjects imperative and scoped when useful. Pull requests should summarize the affected host or module, list validation commands you ran, and include screenshots only for visible desktop changes such as Dock, Ghostty, or Zed configuration updates.

## Security & Configuration Notes
Never commit decrypted secrets. Add new secrets through `secrets/*.age` and wire them into the relevant host config. Keep host-only values in `hosts/<hostname>/default.nix`; shared behavior belongs in reusable modules.
