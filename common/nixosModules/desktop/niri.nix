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
in {
  config = lib.mkIf (cfg.enable && presetName == "niri") {
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };

    security.polkit.enable = true;

    xdg.portal = {
      enable = true;
      configPackages = [pkgs.gnome-session];
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };
}
