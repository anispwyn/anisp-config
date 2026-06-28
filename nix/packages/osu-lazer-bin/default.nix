{
  lib,
  stdenvNoCC,
  fetchurl,
  gamemode,
  fetchzip,
  appimageTools,
  makeWrapper,
  pipewire_latency ? "64/44100", # reasonable default
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
    version = "2026.624.0";
    aarch64-darwin = "sha256-kL2XGJzTRC+AtHH4+byaR1df9EYyIriuxzawDtAFWZ4=";
    x86_64-darwin = "sha256-NOBKnsZpMYU6uBfVqYK3ZrPzZBQURw6bN5rr1iZG9nA=";
    x86_64-linux = "sha256-EKmCq656djPGK5I1JqSDcTKtpbQZbO8WGWcPv+PT0q4=";
  };

  tachyon = {
    version = "2026.623.0";
    aarch64-darwin = "sha256-fpXDW/TJPtjfk2pZmzSatnqkAROLkFvOcZHvXsRabAI=";
    x86_64-darwin = "sha256-tXA6Y/W/KOYGqP0fw0SpPo1oCMO613oTiX8U7tnLIUU=";
    x86_64-linux = "sha256-YJG+z0EPTSptd4FCKY8NgLa7pBBfT35JAuqgw/Ec+ao=";
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

      # fix OpenGL renderer on nvidia + wayland
      extraBwrapArgs = [
        "--ro-bind-try /etc/egl/egl_external_platform.d /etc/egl/egl_external_platform.d"
      ];

      extraInstallCommands = let
        contents = appimageTools.extract {inherit pname version src;};
      in ''
        . ${makeWrapper}/nix-support/setup-hook
        mv -v $out/bin/${pname} $out/bin/osu!

        wrapProgram $out/bin/osu! \
          ${lib.optionalString nativeWayland "--set SDL_VIDEODRIVER wayland"} \
          --set PIPEWIRE_LATENCY "${pipewire_latency}" \
          --set OSU_EXTERNAL_UPDATE_PROVIDER 1 \
          --set OSU_EXTERNAL_UPDATE_STREAM "${releaseStream}" \
          --set vblank_mode "0"

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
