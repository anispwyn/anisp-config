{
  pkgs,
  inputs,
  ...
}: {
  imports = [./home-modules];

  home = {
    homeDirectory = "/home/anisp";
    stateVersion = "25.11";
    shell.enableFishIntegration = true;
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
        (
          eden.overrideAttrs (
            finalAttrs: oldAttrs: let
              edendiscordsrc = fetchFromGitHub {
                owner = "eden-emulator";
                repo = "discord-rpc";
                rev = "0d8b2d6a37";
                hash = "sha256-bsVW2yKgTyIPDyVLKYHxlllLhcY9H5B81+23zJLBIBY=";
              };
            in {
              version = "0.2.0-rc2";

              src = fetchFromGitea {
                domain = "git.eden-emu.dev";
                owner = "eden-emu";
                repo = "eden";
                tag = "v${finalAttrs.version}";
                hash = "sha256-keLkB5qeQch+tM2J6zVh9oQGhP5TuxItqrZRN24apJw=";
              };
              patches = [];
              buildInputs =
                oldAttrs.buildInputs
                ++ [
                  qt6.qtcharts
                  (discord-rpc.overrideAttrs {
                    version = "3.4.1";
                    src = edendiscordsrc;
                    postPatch = '''';
                  })
                ];
              cmakeFlags =
                oldAttrs.cmakeFlags
                ++ [
                  (lib.cmakeBool "USE_DISCORD_PRESENCE" true)
                ];
            }
          )
        )
        proton-vpn
        proton-vpn-cli
        proton-pass-cli
        qbittorrent-enhanced
        tetrio-desktop
        gsettings-desktop-schemas
        obs-studio
        mangohud
        ryubing
        umu-launcher
        jq
        btop
        hoppscotch
        playerctl
        rose-pine-cursor
        gemini-cli-bin
        wl-clipboard
        nautilus
        file-roller
        p7zip-rar
        kdePackages.gwenview
        grim
        slurp
        pear-desktop
        vivaldi-ffmpeg-codecs
        anki
      ]
      ++ [
        inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-lazer-bin
        inputs.zmx.packages.${pkgs.stdenv.hostPlatform.system}.zmx
        inputs.animesteam.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
  };
}
