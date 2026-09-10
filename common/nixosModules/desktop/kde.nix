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

    services.gnome.gnome-keyring.enable = true;

    security.pam.services = {
      login.kwallet.enable = lib.mkForce false;
      kde.kwallet.enable = lib.mkForce false;
      kde.enableGnomeKeyring = true;
    };

    xdg.portal.config.kde = {
      default = ["kde"];
      "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
    };

    environment.etc."xdg/kwalletrc".text = ''
      [Wallet]
      Enabled=false

      [org.freedesktop.secrets]
      apiEnabled=false
    '';
  };
}
