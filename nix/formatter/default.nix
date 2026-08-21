{
  inputs,
  pkgs,
  ...
}:
(inputs.treefmt-nix.lib.evalModule pkgs {
  projectRootFile = "flake.nix";
  programs.alejandra.enable = true;
  settings.formatter.oxfmt = {
    command = pkgs.lib.getExe pkgs.oxfmt;
    options = ["--write"];
    includes = ["*.yml" "*.yaml"];
  };
}).config.build.wrapper
