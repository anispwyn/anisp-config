{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakelight.url = "github:nix-community/flakelight";
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
    };
}
