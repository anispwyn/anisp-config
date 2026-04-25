{
  pkgs,
  config,
  lib,
  ...
}: {
  systemd.services = {
    omen-fan = {
      enable = false;
      description = "Set Omen fan profile";

      wantedBy = ["multi-user.target"];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.omen-fan}/bin/omen-fan e 1";
        ExecStop = "${pkgs.omen-fan}/bin/omen-fan e 0";
        RemainAfterExit = true;
      };
      path = [pkgs.kmod];
    };
  };
  networking.networkmanager.dispatcherScripts = [
    {
      type = "basic";
      source = pkgs.writeShellScript "captive-portal-connect" ''
        INTERFACE="$1"
        STATUS="$2"

        if [ "$STATUS" != "up" ]; then
          exit 0
        fi

        source ${config.sops.templates."wifi".path}

        CURRENT_SSID=$(${pkgs.networkmanager}/bin/nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)

        if [ "$CURRENT_SSID" = "$SSID_NAME" ]; then
          ${pkgs.curl}/bin/curl -X POST \
            -d "username=$USERNAME&password=$PASSWORD" \
            http://192.168.2.1/login
        fi
      '';
    }
  ];

  services = {
    playerctld.enable = true;
    sunshine = {
      enable = false;
      openFirewall = true;
      package = let
        inherit (pkgs.stdenv.hostPlatform) isLinux;
      in
        with pkgs;
          sunshine.overrideAttrs (finalAttrs: oldAttrs: {
            pname = "apollo";
            src = fetchFromGitHub {
              owner = "ClassicOldSong";
              repo = "Apollo";
              rev = "dd99a82";
              hash = "sha256-1nRB3GrEm97u0c1cvQ5QoTPcu/NxgOwJoSGCK16bRmI=";
              fetchSubmodules = true;
            };
            ui = buildNpmPackage {
              inherit (finalAttrs) src version;
              pname = "apollo-ui";
              npmDepsHash = "sha256-FNdZ2YIlbdhwt9BW/rcLOUbPYqMtDW6Pu3jLPU280jY=";

              postPatch = ''
                cp ${./deps/Apollo/package-lock.json} ./package-lock.json
              '';

              installPhase = ''
                runHook preInstall

                mkdir -p "$out"
                cp -a . "$out"/

                runHook postInstall
              '';
            };
            postPatch =
              # don't look for npm since we build webui separately
              ''
                substituteInPlace cmake/targets/common.cmake \
                  --replace-fail 'find_program(NPM npm REQUIRED)' ""
              ''
              # use system boost instead of FetchContent.
              # FETCH_CONTENT_BOOST_USED prevents Simple-Web-Server from re-finding boost
              + ''
                echo 'set(FETCH_CONTENT_BOOST_USED TRUE)' >> cmake/dependencies/Boost_Sunshine.cmake
              ''
              # remove upstream dependency on systemd and udev
              + lib.optionalString isLinux ''
                substituteInPlace cmake/packaging/linux.cmake \
                  --replace-fail 'find_package(Systemd)' "" \
                  --replace-fail 'find_package(Udev)' ""

                substituteInPlace packaging/linux/dev.lizardbyte.app.Sunshine.desktop \
                  --subst-var-by PROJECT_NAME 'Sunshine' \
                  --subst-var-by PROJECT_DESCRIPTION 'Self-hosted game stream host for Moonlight' \
                  --subst-var-by SUNSHINE_DESKTOP_ICON 'sunshine' \
                  --subst-var-by CMAKE_INSTALL_FULL_DATAROOTDIR "$out/share" \
                  --replace-fail '/usr/bin/env systemctl start --u sunshine' 'sunshine'

                substituteInPlace packaging/linux/sunshine.service.in \
                  --subst-var-by PROJECT_DESCRIPTION 'Self-hosted game stream host for Moonlight' \
                  --subst-var-by SUNSHINE_EXECUTABLE_PATH $out/bin/sunshine \
                  --replace-fail '/bin/sleep' '${lib.getExe' coreutils "sleep"}'
              '';
          });
    };
    resolved = {
      settings.Resolve = {
        DNS = "127.0.0.1";
        Domains = "~.";
      };
    };
    desktopManager.plasma6.enable = false;
    scx = {
      enable = false;
      scheduler = "scx_rustland";
    };
    openssh = {
      enable = false;
      ports = [2222];
      settings = {
        UseDns = true;
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = ["anisp"];
        Banner = "idk man you connected or something\n";
      };
    };

    suwayomi-server = {
      enable = true;
      openFirewall = true;
      settings = {
        server = {
          webUIChannel = "PREVIEW";
          autoDownloadNewChapters = true;
          updateMangas = true;
          authMode = "none";
          flareSolverrEnabled = true;
          extensionRepos = ["https://raw.githubusercontent.com/yuzono/manga-repo/repo/index.min.json"];
        };
      };
    };
    flaresolverr = {
      openFirewall = false;
      enable = true;
    };
    tailscale = {
      enable = true;
      extraUpFlags = [
        "--accept-dns=false"
      ];
    };
    nextdns = {
      enable = true;
    };
  };
  systemd.services.nextdns.serviceConfig.ExecStart = lib.mkForce (
    pkgs.writeShellScript "nextdns-start" ''
      exec ${pkgs.nextdns}/bin/nextdns run -config "$(cat ${config.sops.secrets.nextdns_profile.path})"
    ''
  );
  virtualisation = {
    podman = {
      enable = false;
      autoPrune.enable = true;
      dockerSocket.enable = true;
      dockerCompat = true;
      defaultNetwork.settings = {dns_enabled = true;};
    };
  };

  # security.sudo.extraRules = [
  #   {
  #     users = ["anisp"];
  #     commands = [
  #       {
  #         command = "/run/current-system/sw/bin/podman";
  #         options = ["NOPASSWD"];
  #       }
  #     ];
  #   }
  # ];
}
