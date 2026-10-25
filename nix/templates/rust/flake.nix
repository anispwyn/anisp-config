{
  inputs = {
    flakelight.url = "github:nix-community/flakelight";

    crane.url = "github:ipetkov/crane";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    flakelight,
    fenix,
    crane,
    ...
  } @ inputs:
    flakelight ./. {
      inherit inputs;
      withOverlays = [fenix.overlays.default];

      packages.default = {pkgs, ...}: let
        craneLib = crane.mkLib pkgs;
        projectInfo = (fromTOML (builtins.readFile ./Cargo.toml)).package;

        commonArgs = {
          nativeBuildInputs = [
            pkgs.pkg-config
          ];

          buildInputs = [
            pkgs.openssl
          ];
        };

        deps = craneLib.buildDepsOnly ({
            version = "0.0.1";
            pname = "deps";
            src = ./.;
          }
          // commonArgs);
      in
        craneLib.buildPackage ({
            src = ./.;
            pname = projectInfo.name;
            version = projectInfo.version;
            cargoArtifacts = deps;
          }
          // commonArgs);

      devShell.packages = pkgs: [
        pkgs.fenix.default.toolchain
        pkgs.pkg-config
        pkgs.openssl
      ];

      formatter = pkgs:
        (inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          programs.rustfmt.enable = true;
        }).config.build.wrapper;
    };
}
