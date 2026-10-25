{
  lib,
  stdenvNoCC,
  fetchurl,
  gamemode,
  fetchzip,
  appimageTools,
  makeWrapper,
  sample_size ? "64",
  pipewire_latency ? "${sample_size}/44100", # reasonable default
  nativeWayland ? true,
  gmrun_enable ? true,
  command_prefix ?
    if gmrun_enable
    # won't hurt users even if they don't have it set up
    then "${gamemode}/bin/gamemoderun"
    else null,
  releaseStream ? "lazer",
}: let
  pname = "osu-lazer-bin";

  lazer = {
    version = "2026.1005.0";
    aarch64-darwin = "sha256-ZxiW0ghB1ayNjRo9FqAfeBjT5dMM+j74TGDkWHCcdk8=";
    x86_64-darwin = "sha256-ikpeZbJRRqNkDHsL9rD+supLgc8shZe6pWl6/3p8wbM=";
    x86_64-linux = "sha256-KEEI5lNzqDOb7spA4sFLFSjBd71s4eshQHY5+OUI2i4=";
  };

  tachyon = {
    version = "2026.1026.0";
    aarch64-darwin = "sha256-ikV2nQFtvq3Q4FOYrNSK/CObkPBR6mYmfhzfxfe7iAM=";
    x86_64-darwin = "sha256-69dBiwj5+j6qTEHMw/xW5xbvyYLsXkPLBnr1jU8fXq4=";
    x86_64-linux = "sha256-gF6wrkVfdSolzYXX/Y9ZHqjlKD7fwbm7eJ1NrdQuiwA=";
  };

  useTachyon = releaseStream == "tachyon" && (lib.versionOlder lazer.version tachyon.version);

  active =
    if useTachyon
    then tachyon
    else lazer;
  suffix =
    if useTachyon
    then "tachyon"
    else "lazer";
  inherit (active) version;

  src =
    {
      aarch64-darwin = fetchzip {
        url = "https://github.com/ppy/osu/releases/download/${version}-${suffix}/osu.app.Apple.Silicon.zip";
        hash = active.aarch64-darwin;
        stripRoot = false;
      };
      x86_64-darwin = fetchzip {
        url = "https://github.com/ppy/osu/releases/download/${version}-${suffix}/osu.app.Intel.zip";
        hash = active.x86_64-darwin;
        stripRoot = false;
      };
      x86_64-linux = fetchurl {
        url = "https://github.com/ppy/osu/releases/download/${version}-${suffix}/osu.AppImage";
        hash = active.x86_64-linux;
      };
    }
    .${
      stdenvNoCC.system
    } or (throw "osu-lazer-bin: ${stdenvNoCC.system} is unsupported.");

  meta = {
    description = "Rhythm is just a *click* away (AppImage version for score submission and multiplayer, and binary distribution for Darwin systems)";
    homepage = "https://osu.ppy.sh";
    license = with lib.licenses; [
      mit
      cc-by-nc-40
      unfreeRedistributable # osu-framework contains libbass.so in repository
    ];
    sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    maintainers = with lib.maintainers; [
      gepbird
      stepbrobd
      Guanran928
    ];
    mainProgram = "osu!";
    platforms = [
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  };

  passthru.updateScript = ./update.sh;
in
  if stdenvNoCC.hostPlatform.isDarwin
  then
    stdenvNoCC.mkDerivation {
      inherit
        pname
        version
        src
        meta
        passthru
        ;

      nativeBuildInputs = [makeWrapper];

      installPhase = ''
        runHook preInstall
        OSU_WRAPPER="$out/Applications/osu!.app/Contents"
        OSU_CONTENTS="osu!.app/Contents"
        mkdir -p "$OSU_WRAPPER/MacOS"
        cp -r "$OSU_CONTENTS/Info.plist" "$OSU_CONTENTS/Resources" "$OSU_WRAPPER"
        cp -r "osu!.app" "$OSU_WRAPPER/Resources/osu-wrapped.app"
        makeWrapper "$OSU_WRAPPER/Resources/osu-wrapped.app/Contents/MacOS/osu!" "$OSU_WRAPPER/MacOS/osu!" --set OSU_EXTERNAL_UPDATE_PROVIDER 1
        runHook postInstall
      '';
    }
  else
    appimageTools.wrapType2 {
      inherit
        pname
        version
        src
        meta
        passthru
        ;

      extraPkgs = pkgs: with pkgs; [icu];

      extraInstallCommands = let
        contents = appimageTools.extract {inherit pname version src;};
      in ''
        . ${makeWrapper}/nix-support/setup-hook
        mv -v $out/bin/${pname} $out/bin/osu!

        wrapProgram $out/bin/osu! \
          ${lib.optionalString nativeWayland "--set SDL_VIDEODRIVER wayland"} \
          --set OSU_TEMP_TESTING_BASS_CONFIG_DEV_PERIOD "-${sample_size}" \
          --set PIPEWIRE_ALSA '{ "alsa.period-bytes": 512, "alsa.periods": 2 }' \
          --set PIPEWIRE_LATENCY "${pipewire_latency}" \
          --set OSU_EXTERNAL_UPDATE_PROVIDER 1 \
          --set OSU_EXTERNAL_UPDATE_STREAM "${releaseStream}" \

        ${
          # a hack to infiltrate the command in the wrapper
          lib.optionalString (builtins.isString command_prefix) ''
            sed -i '$s:exec -a "$0":exec ${command_prefix}:' $out/bin/osu!
          ''
        }

        install -m 444 -D ${contents}/osu!.desktop -t $out/share/applications
        for i in 16 32 48 64 96 128 256 512 1024; do
          install -D ${contents}/osu.png $out/share/icons/hicolor/''${i}x$i/apps/osu.png
        done
      '';
    }
