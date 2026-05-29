{
  pkgs,
  inputs,
  ...
}: {
  imports = [./homeModules];
  home = {
    shell.enableFishIntegration = true;
    homeDirectory = "/home/anisp";
    stateVersion = "25.11";
    packages = with pkgs;
      [
        # games goes here
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
        mangohud
        ryubing
        umu-launcher
        tetrio-desktop
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
        (osu-lazer-bin.override {
          releaseStream = "tachyon";
        })
        heroic

        # audio production stuff goes here
        reaper
        yabridge
        yabridgectl

        # idk
        qbittorrent-enhanced
        gsettings-desktop-schemas
        obs-studio
        btop
        hoppscotch
        playerctl
        rose-pine-cursor
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
        antigravity-cli
      ]
      ++ [
        inputs.animesteam.packages.${pkgs.stdenv.hostPlatform.system}.default
        # inputs.accela.packages.${pkgs.stdenv.hostPlatform.system}.default
        # inputs.slsteam.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
  };

  my.audio.plugins = with pkgs; [
    vital
  ];
}
