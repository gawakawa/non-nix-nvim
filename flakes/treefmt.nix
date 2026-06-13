_: {
  perSystem = _: {
    treefmt = {
      programs = {
        nixfmt = {
          enable = true;
          includes = [ "*.nix" ];
        };
        stylua = {
          enable = true;
          includes = [ "*.lua" ];
        };
      };
    };
  };
}
