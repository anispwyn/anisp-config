{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.desktop;
  presetName =
    if cfg.preset != null
    then cfg.preset
    else cfg.presets;
  isNiri = cfg.enable && presetName == "niri";
in {
  imports = [
    ./dms.nix
    ./niri.nix
    ./plasma.nix
  ];

  options.my.desktop = {
    enable = lib.mkEnableOption "desktop environment";
    presets = lib.mkOption {
      type = lib.types.enum ["niri" "kde" "gnome"];
      default = "niri";
      description = "Desktop preset to use (niri, kde, gnome)";
    };
    preset = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum ["niri" "kde" "gnome"]);
      default = null;
      description = "Alias for presets";
    };
  };

  config = lib.mkIf isNiri {
    home.packages = with pkgs; [
      nautilus
      file-roller
      kdePackages.gwenview
      rose-pine-cursor
      oniri
      gcr_4 # HACK https://github.com/nix-community/home-manager/issues/1454
    ];
  };
}
