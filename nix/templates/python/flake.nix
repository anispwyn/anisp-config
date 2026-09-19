{
  inputs = {
    flakelight.url = "github:nix-community/flakelight";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {flakelight, ...} @ inputs:
    flakelight ./. {
      inherit inputs;
      devShell.packages = pkgs: with pkgs; [python315FreeThreading uv];
      formatter = pkgs:
        (inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          programs.ruff.enable = true;
        }).config.build.wrapper;
    };
}
