# CLAUDE.md

## Policy

The config under `nvim/` uses no nix and keeps dependencies minimal so it can be used at work. "Minimal" means easier to get approved internally, not truly few dependencies including transitive ones.

## Commands

- `nix fmt` - Format code
- `nix flake check` - Run checks (format, lint)
- `nix build` - Build the project
