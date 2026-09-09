{inputs, ...}: {
  specialArgs = {
    inherit inputs;
  };

  modules = [
    ../../hosts/cutie
    ../../common
  ];
}
