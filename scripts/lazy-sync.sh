#!/usr/bin/env bash
# Regenerate nvim/lazy-lock.json by running lazy.nvim in headless mode.
#
# Usage:
#   lazy-sync.sh           -- update lock in working tree only
#   lazy-sync.sh --stage   -- also stage the lock file (for pre-commit hook)
#
# Requires network on first run (clones lazy.nvim and all plugin specs).
# Uses the isolated XDG dirs declared in ~/.zshrc alias `non-nix-nvim` so that
# the main Neovim config (~/.local/share/nvim) is never touched.
set -euo pipefail

REPO="$(git rev-parse --show-toplevel)"
export XDG_CONFIG_HOME="$REPO"
export XDG_DATA_HOME="$HOME/.local/share/non-nix-nvim"
export XDG_STATE_HOME="$HOME/.local/state/non-nix-nvim"

echo "[lazy-sync] running Lazy! install+clean via headless neovim…"
# Use install+clean instead of sync to avoid bumping unrelated plugins to latest.
# Headless neovim may exit non-zero on warnings; treat that as success.
nix run nixpkgs#neovim -- --headless "+Lazy! install" "+Lazy! clean" +qa || true

echo "[lazy-sync] done — lock updated at nvim/lazy-lock.json"

if [ "${1:-}" = "--stage" ]; then
    if [ ! -f "$REPO/nvim/lazy-lock.json" ]; then
        echo "[lazy-sync] warning: nvim/lazy-lock.json not found, skipping stage" >&2
    elif git diff --quiet "$REPO/nvim/lazy-lock.json"; then
        echo "[lazy-sync] lazy-lock.json unchanged, skipping stage" >&2
    else
        git add "$REPO/nvim/lazy-lock.json"
        echo "[lazy-sync] lazy-lock.json staged"
    fi
fi
