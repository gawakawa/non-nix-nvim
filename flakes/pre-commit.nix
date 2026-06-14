_: {
  perSystem =
    { pkgs, ... }:
    {
      pre-commit.settings.hooks = {
        treefmt.enable = true;
        selene.enable = true;
        statix.enable = true;
        deadnix.enable = true;
        actionlint.enable = true;
        zizmor = {
          enable = true;
          args = [ "--offline" ];
        };
        lazy-lock-sync = {
          enable = true;
          name = "lazy-lock sync";
          # Only fires when a plugin spec or the lazy setup file is staged.
          # Runs headless Lazy! sync and re-stages lazy-lock.json so both
          # the spec change and the lock land in the same commit.
          # Skip with: SKIP=lazy-lock-sync git commit
          files = "^nvim/lua/(plugins/.*|config/lazy)\\.lua$";
          pass_filenames = false;
          language = "system";
          entry = "bash scripts/lazy-sync.sh --stage";
        };
        workflow-timeout = {
          enable = true;
          name = "Check workflow timeout-minutes";
          package = pkgs.check-jsonschema;
          entry = "${pkgs.check-jsonschema}/bin/check-jsonschema --builtin-schema github-workflows-require-timeout";
          files = "\\.github/workflows/.*\\.ya?ml$";
        };
      };
    };
}
