{inputs, ...}: let
  system = "x86_64-linux";
in {
  inherit system;

  specialArgs = {
    inherit inputs system;
  };

  modules = [
    ../../hosts/cutie
    ../../modules
  ];
}
