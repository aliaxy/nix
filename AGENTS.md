# Repository Guidelines

This file is the operating guide for coding agents working in this Nix
configuration repository. Keep changes declarative, small, and easy to verify.

## Overview

This repository is a flake-based macOS configuration for `nix-darwin`, Home
Manager, `nix-homebrew`, Catppuccin, and project dev-shell templates.

Hosts are `mba-m4` (MacBook Air M4, primary) and `mbp-m1pro` (MacBook Pro M1
Pro), owned by user `aliaxy`, and built through `lib.mkDarwinSystem`.
Host-specific choices live under `hosts/<hostname>/`; shared Darwin and Home
Manager behavior lives in reusable modules.

## Build, Check, and Apply Commands

Run commands from the repository root.

- `nix flake show`: inspect exported outputs and catch basic flake issues.
- `nix build .#darwinConfigurations.mba-m4.system`: build the active macOS
  system closure without switching.
- `darwin-rebuild switch --flake .#mba-m4`: apply the active host
  configuration.
- `drb`: shell shortcut for rebuilding the current Darwin host, when the
  managed shell is active.

For focused option checks, prefer `nix eval` before a full build, for example:

- `nix eval .#darwinConfigurations.mba-m4.config.my.darwin.dock.position --raw`
- `nix eval .#darwinConfigurations.mba-m4.config.my.home.profiles.dev --json`

If the sandbox cannot connect to the Nix daemon, report that limitation instead
of claiming the build was verified.

## Project Structure

```text
nix/
├── flake.nix                 # Flake inputs, host exports, dev-shell templates
├── flake.lock                # Locked input revisions
├── lib/default.nix           # mkDarwinSystem host builder
├── hosts/mba-m4/             # MacBook Air M4 host values
├── hosts/mbp-m1pro/          # MacBook Pro M1 Pro host values
├── modules/common/           # Cross-platform Nix and Home Manager wiring
├── modules/darwin/           # macOS system, Homebrew, apps, packages
├── home/default.nix          # Home Manager entry point and shared imports
├── home/profiles/            # Opt-in user profiles such as base and dev
├── home/programs/            # Larger per-program Home Manager modules
└── templates/                # Flake templates for project dev shells
```

## Configuration Model

- `flake.nix` exports `darwinConfigurations.mba-m4`,
  `darwinConfigurations.mbp-m1pro`, and project templates.
- `lib/default.nix` assembles each Darwin host with shared modules and passes
  `inputs`, `self`, `hostname`, and `username` through `specialArgs`.
- `hosts/<hostname>/default.nix` contains only host-specific values: enabled
  suites, Dock additions, Homebrew overrides, and Home Manager profile choices.
- `modules/common/home.nix` defines `my.home.profiles.*` and wires Home Manager
  imports. Base always pulls nvim/fish/starship/yazi/ghostty; dev pulls Zed.
  Only `my.home.programs.aerospace` is an optional host toggle.
- `modules/darwin/apps.nix` defines high-level GUI suites and resolves app
  bundles.
- `modules/darwin/homebrew.nix` merges suite casks with host-specific casks,
  taps, brews, and MAS apps.
- `modules/darwin/system.nix` owns macOS defaults, Dock settings, the primary
  user, and the Fish login shell activation script.
- `home/profiles/base.nix` is for core CLI and everyday user environment.
- `home/profiles/dev.nix` is for developer tools, Git, SSH, direnv, AI tools,
  OpenSpec, and mirrors.

## Editing Rules

- Use the existing Nix style: 2-space indentation, trailing semicolons, compact
  modules, and one logical concern per file.
- Prefer adding host-specific values to `hosts/<hostname>/default.nix`.
- Put shared macOS behavior in `modules/darwin/` and shared user behavior in
  `home/profiles/` or `home/programs/`.
- Do not hardcode `/Users/aliaxy` in modules. Use `username`, `hostname`, Home
  Manager options, or module arguments.
- Keep reusable option names under the existing `my.*` namespace.
- Prefer declarative Nix options over imperative activation scripts. Use
  activation scripts only for gaps that Nix modules do not cover.
- Keep comments short and explain intent or platform quirks, not syntax.
- Do not introduce broad refactors while making a narrow configuration change.

## Common Change Locations

- Add or remove GUI apps: update suites in `modules/darwin/apps.nix`, or host
  overrides in `hosts/<hostname>/default.nix` under `my.darwin.homebrew`.
- Change Dock, Finder, shell, or macOS defaults: edit
  `modules/darwin/system.nix` or host-specific Dock values.
- Add CLI tools for everyone using the base profile: edit `home/profiles/base.nix`.
- Add developer-only tools: edit `home/profiles/dev.nix`.
- Add a larger app configuration: create or update `home/programs/<name>.nix`
  and import it from the relevant profile.
- Add a new host: create `hosts/<hostname>/`, then add a
  `darwinConfigurations.<hostname>` entry in `flake.nix`.
- Add a dev-shell template: create `templates/<language>/flake.nix` and expose
  it from `flake.nix`.
- Update shell shortcuts: edit `home/programs/fish.nix`.

## Homebrew and App Suite Rules

- Suite casks should remain plain strings in `modules/darwin/apps.nix`.
- Host `extraCasks` may be plain strings or attrsets with `name` and `greedy`.
- Host `extraCasks` override suite casks with the same name.
- Use `excludeCasks` or `excludeMasApps` for host-specific removals instead of
  weakening a shared suite.
- Keep `nix-homebrew.inputs.brew-src.url` explicit in `flake.nix`.

## Secrets and Local State

- Never commit decrypted secrets.
- This repository currently has no SOPS wiring or tracked `secrets/` directory.
  If secrets are reintroduced, keep encrypted material only and document the
  new wiring before use.
- Do not commit generated caches or personal local state.
- `openspec/` may contain project specs if the user chooses to track them, but
  do not add or commit untracked OpenSpec artifacts without explicit approval.

## Git Workflow

- Do not stage, commit, amend, reset, or revert unless the user explicitly asks.
- Before committing, show or summarize the intended commit grouping.
- **Always run `nix fmt .` from the repository root before every commit.**
  Stage any formatting changes it produces (or include them in the same
  commit). Do not commit unformatted Nix.
- Use Conventional Commit subjects, matching the existing history:
  `feat(dev): ...`, `feat(darwin): ...`, `chore(flake): ...`,
  `docs(flake): ...`, `refactor(home): ...`.
- Split unrelated changes into separate commits: profile changes, app-suite
  changes, lockfile/input updates, and documentation updates should not be
  mixed unless the user asks for a single commit.
- Never revert user changes just to make the worktree clean.

## Validation Strategy

There is no dedicated test suite. Validate with the smallest command that proves
the change, then escalate as needed.

1. Run `nix fmt .` so the tree matches the alejandra formatter.
2. Run `git diff --check` for whitespace and patch hygiene.
3. Run `nix flake show` for output-level validation.
4. Use `nix eval` for changed host options or profile toggles.
5. Run `nix build .#darwinConfigurations.mba-m4.system` before claiming the
   active system builds.
6. Only run `darwin-rebuild switch --flake .#mba-m4` when the user wants the
   configuration applied.

For visible desktop changes, mention that manual inspection may still be needed
after switching, especially for Dock, Finder, Ghostty, Zed, Aerospace, or
Homebrew cask behavior.

## Agent Notes

- Read nearby modules before editing; this repo favors small modules with
  explicit ownership.
- Prefer `rg` and `rg --files` for exploration.
- Preserve the user's current worktree, including untracked files.
- When validation cannot run because of sandbox, daemon, or network limits,
  report the exact blocker and what was verified instead.
- Keep responses concise and concrete. The user usually wants the change made,
  the validation result, and any remaining risk.
