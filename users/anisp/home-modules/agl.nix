{inputs, ...}: {
  imports = [inputs.animesteam.homeModules.default];
  programs.agl = {
    enable = true;
    anirun.enable = true;
    settings = {
      cache = {
        game_manifests.duration = 0;
        game_registries.duration = 0;
        game_packages.duration = 0;
        packages_allow_lists.duration = 0;
      };
    };
  };
}
