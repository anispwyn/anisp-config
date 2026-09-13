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
        (osu-lazer-bin.override {
          releaseStream = "tachyon";
        })
        heroic

        # idk
        gnupg1
        xdg-utils
        fzf
        bat
        jq
        ripgrep
        qbittorrent-enhanced
        gsettings-desktop-schemas
        obs-studio
        btop
        bruno
        playerctl
        wl-clipboard
        _7zz-rar
        openssl
        pear-desktop
        moltorino
        nicotine-plus
        element-desktop
        feishin

        jetbrains.datagrip

        # keyring bs
        proton-authenticator
        seahorse
      ]
      ++ [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.antigravity-cli
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
      ];
  };
}
