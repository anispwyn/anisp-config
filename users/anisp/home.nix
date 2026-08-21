{pkgs, ...}: {
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
        (tetrio-desktop.override {
          electron = electron_43;
        })
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
        bruno
        playerctl
        rose-pine-cursor
        wl-clipboard
        nautilus
        file-roller
        _7zz-rar
        kdePackages.gwenview
        openssl
        pear-desktop
        oniri
        niri-sidebar
        moltorino
        nicotine-plus
        element-desktop
        figma-agent
        feishin

        jetbrains.datagrip

        # keyring bs
        proton-authenticator
        seahorse
        gcr # HACK https://github.com/nix-community/home-manager/issues/1454
      ]
      ++ [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.antigravity-cli
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop
      ];
  };

  my.audio.plugins = with pkgs; [
    vital
  ];
}
