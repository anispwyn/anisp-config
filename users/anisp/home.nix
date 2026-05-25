{
  pkgs,
  inputs,
  ...
}: {
  imports = [./home-modules];
  home = {
    shell.enableFishIntegration = true;
    homeDirectory = "/home/anisp";
    stateVersion = "25.11";
    packages = with pkgs;
      [
        (prismlauncher.override {
          jdks = [
            temurin-bin-25
            temurin-bin-21
            temurin-bin-17
            temurin-bin-8
          ];
          additionalLibs = [
            libxkbcommon
            libxt
            libxtst
            libXinerama
          ];
        })
        eden
        qbittorrent-enhanced
        tetrio-desktop
        gsettings-desktop-schemas
        obs-studio
        mangohud
        ryubing
        umu-launcher
        btop
        hoppscotch
        playerctl
        rose-pine-cursor
        gemini-cli-bin
        wl-clipboard
        nautilus
        file-roller
        _7zz-rar
        kdePackages.gwenview
        grim
        slurp
        openssl
        pear-desktop
        blender
        oniri
        mindustry
        (waydroid-helper.overrideAttrs
          (finalAttrs: oldAttrs: {
            version = "0.2.9";
            src = fetchFromGitHub {
              owner = "ayasa520";
              repo = "waydroid-helper";
              tag = "v${finalAttrs.version}";
              hash = "sha256-6mVb4GPD2NCsvyaqQAOFox0rNIlyOttiaZKbHBS40Rg=";
            };
            propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [pkgs.vte-gtk4];
          }))
        seahorse
        (osu-lazer-bin.override {
          releaseStream = "tachyon";
        })
        heroic
        antigravity-cli
        reaper
        yabridge
        yabridgectl
      ]
      ++ [
        inputs.animesteam.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
  };
}
