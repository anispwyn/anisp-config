{
  inputs = {
    flakelight.url = "github:nix-community/flakelight";
    zig2nix.url = "github:cloudef/zig2nix";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    flakelight,
    zig2nix,
    ...
  } @ inputs: let
    zigEnv = stdenv: zig2nix.outputs.zig-env.${stdenv.hostPlatform.system} {};
  in
    flakelight ./. {
      packages = rec {
        foreign = {
          stdenv,
          lib,
          ...
        }:
          (zigEnv stdenv).package {
            src = lib.cleanSource ./.;
            nativeBuildInputs = [];
            buildInputs = [];
            zigPreferMusl = true;
          };

        default = {
          stdenv,
          lib,
          ...
        }:
          (foreign {inherit stdenv lib;}).override (attrs: {
            zigPreferMusl = false;
            zigWrapperBins = [];
            zigWrapperLibs = attrs.buildInputs or [];
          });
      };

      devShell.packages = pkgs: with pkgs; [zig zls];

      formatter = pkgs:
        (inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
            zig.enable = true;
          };
        }).config.build.wrapper;
    };
}
