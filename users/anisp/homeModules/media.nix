{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.spicetify];

  programs = {
    mpv = {
      enable = true;
    };
    spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
    in {
      enable = true;
      enabledCustomApps = with spicePkgs.apps; [newReleases lyricsPlus betterLibrary];
      enabledExtensions = with spicePkgs.extensions; [trashbin shuffle powerBar wikify songStats lastfm aiBandBlocker volumePercentage beautifulLyrics adblock betterGenres fullScreen];
    };
    ncmpcpp = {
      enable = config.services.mpd.enable;
      package = pkgs.ncmpcpp.override {
        visualizerSupport = true;
      };
    };
  };
  services = {
    mpd = {
      enable = false;
      musicDirectory = "${config.home.homeDirectory}/Music";
      enableSessionVariables = false;
      network = {
        startWhenNeeded = true;
        listenAddress = "any";
      };
      extraConfig = ''
        auto_update "yes"

        audio_output {
          type "pipewire"
          name "Music Player Daemon"
        }

        audio_output {
          type "fifo"
          name "my_fifo"
          path  "/tmp/mpd.fifo"
          format "44100:16:2"
        }
      '';
    };
    mpdris2-rs.enable = config.services.mpd.enable;
    mpd-discord-rpc.enable = config.services.mpd.enable;
    mpdscribble = {
      enable = true;
      endpoints = {
        "last.fm" = {
          url = "https://post.audioscrobbler.com/";
          passwordFile = "/run/secrets/lastfm_password";
          username = "fame1219";
        };
        "listenbrainz" = {
          url = "http://proxy.listenbrainz.org/";
          username = "anisphia";
          passwordFile = "/run/secrets/listenbrainz_token";
        };
      };
    };
  };
}
