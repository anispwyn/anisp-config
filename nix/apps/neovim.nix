{
  outputs,
  lib,
  ...
}: {
  type = "app";
  program = lib.getExe outputs.nixosConfigurations.cutie.config.home-manager.users."anisp".programs.nvf.finalPackage;
}
