{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.musnix.nixosModules.musnix];
  musnix = {
    enable = false;
    kernel.realtime = false;
    kernel.packages = pkgs.linuxPackages_latest;
  };
}
