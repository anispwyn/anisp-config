{lib, ...}: {
  imports = [
    ./dux.nix
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
}
