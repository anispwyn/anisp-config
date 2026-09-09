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

    home-manager.users.anisp = {
      imports = [
        ../../../users/anisp/homeModules/dms.nix
        ../../../users/anisp/homeModules/niri.nix
      ];

      home.packages = with pkgs; [
        nautilus
        file-roller
        kdePackages.gwenview
        rose-pine-cursor
        oniri
        gcr_4 # HACK https://github.com/nix-community/home-manager/issues/1454
      ];
    };
  };
}
