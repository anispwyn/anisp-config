{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.my.audio;

  joinedPlugins = pkgs.symlinkJoin {
    name = "home-manager-audio-plugins";
    paths = cfg.plugins;
    postBuild = ''
      mkdir -p $out/lib/vst $out/lib/vst3 $out/lib/lxvst $out/lib/ladspa $out/lib/lv2 $out/lib/dssi $out/lib/clap
    '';
  };
in {
  options.my.audio = {
    plugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "List of audio plugin packages from nixpkgs to install and link.";
    };
  };

  config = {
    home.packages = cfg.plugins;

    home.file = {
      ".vst" = {
        source = "${joinedPlugins}/lib/vst";
        recursive = true;
      };
      ".vst3" = {
        source = "${joinedPlugins}/lib/vst3";
        recursive = true;
      };
      ".lxvst" = {
        source = "${joinedPlugins}/lib/lxvst";
        recursive = true;
      };
      ".ladspa" = {
        source = "${joinedPlugins}/lib/ladspa";
        recursive = true;
      };
      ".lv2" = {
        source = "${joinedPlugins}/lib/lv2";
        recursive = true;
      };
      ".dssi" = {
        source = "${joinedPlugins}/lib/dssi";
        recursive = true;
      };
      ".clap" = {
        source = "${joinedPlugins}/lib/clap";
        recursive = true;
      };
    };

    xdg.configFile = {
      "REAPER" = {
        enable = true;
        source = pkgs.symlinkJoin {
          name = "reaper-plugins";
          paths = with pkgs; [
            reaper-reapack-extension
            reaper-sws-extension
          ];
        };
        recursive = true;
        force = true;
      };
    };
  };
}
