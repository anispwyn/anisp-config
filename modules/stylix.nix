{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix = {
    enable = true;

    # experimental
    palette = {
      generators.semantic = config.stylix.lib.generators.semantic.matugen {
        scheme = "tonal-spot";
        filter = "lanczos3";
      };
      mappingFunction = x: config.stylix.lib.mappings.base162base24 (config.stylix.lib.mappings.semantic2base16 x);
    };

    image = ../users/anisp/assets/Wallpapers/143781108_p0.jpg;
    # base16Scheme = "${inputs.tt-schemes}/base16/rose-pine.yaml";
    polarity = "dark";
    targets = {
      fontconfig.enable = true;
    };
    fonts = {
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      monospace = {
        package = pkgs.google-sans-code-nerd-font;
        name = "Google Sans Code NF";
      };
    };
  };
}
