{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakelight.url = "github:nix-community/flakelight";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {flakelight, ...} @ inputs:
    flakelight ./. {
      inherit inputs;

      devShells.default = {
        inputsFrom = pkgs: [pkgs.default];
      };

      packages.default = pkgs:
        pkgs.buildGoModule {
          pname = "template";
          version = "0.1.0";
          src = ./.;
          vendorHash = null;
        };

      formatter = pkgs:
        (inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          settings.formatter.gopls = {
            command = pkgs.lib.getExe pkgs.gopls;
            options = ["format" "-w"];
            includes = ["*.go"];
          };
        }).config.build.wrapper;
    };
}
