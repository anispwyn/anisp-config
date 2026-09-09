{
  config,
  lib,
  ...
}: let
  cfg = config.my.desktop;
  presetName =
    if cfg.preset != null
    then cfg.preset
    else cfg.presets;
in {
  config = lib.mkIf (cfg.enable && presetName == "kde") {
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = lib.mkDefault true;
      wayland.enable = lib.mkDefault true;
    };
  };
}
