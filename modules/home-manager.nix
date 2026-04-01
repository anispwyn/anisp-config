{
  inputs,
  system,
  flake,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      anisp = ../users/anisp/home.nix;
    };
    extraSpecialArgs = {
      inherit inputs system;
      inherit (flake) src;
    };
  };
}
