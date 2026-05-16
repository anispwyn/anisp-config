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
    flatpak.enable = true;
    playerctld.enable = true;
    sunshine = {
      enable = false;
      openFirewall = true;
      package = pkgs.apollo;
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
    waydroid = {
      enable = true;
      package = pkgs.waydroid.override {
        withNftables = true;
      };
    };
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
