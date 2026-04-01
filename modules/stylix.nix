{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
  stylix = {
    enable = true;
    # image = inputs.self + /assets/Wallpapers/1.png;
    base16Scheme = "${inputs.tt-schemes}/base16/rose-pine.yaml";
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
