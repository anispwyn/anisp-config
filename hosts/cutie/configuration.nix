{
  pkgs,
  config,
  ...
}: {
  boot = {
    kernelParams = ["idle=poll"];
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
  };

  networking.hostName = "cutie";

  time.timeZone = "Asia/Bangkok";

  services = {
    xserver.videoDrivers = ["nvidia"];
  };
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      dynamicBoost.enable = true;
      prime = {
        offload.enable = true;
        offload.enableOffloadCmd = true;
        amdgpuBusId = "PCI:7@0:0:0";
        nvidiaBusId = "PCI:1@0:0:0";
      };
    };
    bluetooth.enable = true;
  };
  users.users.anisp = {
    shell = pkgs.fish;
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "input" "docker"];
    openssh = {
      authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHDiVWG/LvNyd46LYg3aqCEqXOdMVxGAO+lMY5Je65m"];
    };
  };
  environment = {
    # etc."systemd/resolved.conf.d/nextdns.conf".source = config.sops.templates."resolved-nextdns".path;
    systemPackages = with pkgs; [
      omen-fan
      (steam.override {
        extraLibraries = p:
          with p; [
            xdg-utils
            libxscrnsaver
            libXxf86vm
          ];
      }).run-free
    ];
    etc."omen-fan/config.toml" = {
      text = ''
        [service]
        TEMP_CURVE = [50, 60, 70, 80, 87, 93]
        SPEED_CURVE = [20, 40, 60, 70, 85, 100]
        IDLE_SPEED = 0
        POLL_INTERVAL = 1

        [script]
        BYPASS_DEVICE_CHECK = 1
      '';
    };
  };

  programs = {
    gamescope.enable = true;
    steam = {
      enable = true;
      protontricks.package = pkgs.protontricks.overrideAttrs {
        src = pkgs.fetchFromGitHub {
          owner = "Matoking";
          repo = "protontricks";
          tag = "older tag";
          hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };
      };
      package = pkgs.steam.override {
        extraLibraries = p:
          with p; [
            libxscrnsaver
          ];
      };
    };
    gamemode.enable = true;
  };

  sops = {
    defaultSopsFile = ../../secrets/anisp.yaml;

    age.keyFile = "/var/lib/sops/keys.txt";
    age.generateKey = true;

    secrets = {
      nextdns_profile = {};
      wifi_ssid_name = {};
      wifi_username = {};
      wifi_password = {};
    };

    templates = {
      wifi = {
        content = ''
          SSID_NAME="${config.sops.placeholder.wifi_ssid_name}";
          USERNAME="${config.sops.placeholder.wifi_username}";
          PASSWORD="${config.sops.placeholder.wifi_password}";
        '';
        mode = "0400";
      };

      # resolved-nextdns = {
      #   content = ''
      #     [Resolve]
      #     DNS=45.90.28.0#${config.sops.placeholder.nextdns_profile}.dns.nextdns.io
      #     DNS=2a07:a8c0::#${config.sops.placeholder.nextdns_profile}.dns.nextdns.io
      #     DNS=45.90.30.0#${config.sops.placeholder.nextdns_profile}.dns.nextdns.io
      #     DNS=2a07:a8c1::#${config.sops.placeholder.nextdns_profile}.dns.nextdns.io
      #     DNSOverTLS=yes
      #   '';
      #   mode = "0440";
      #   group = "systemd-resolve";
      #   restartUnits = ["systemd-resolved.service"];
      # };
    };
  };

  system.stateVersion = "25.11";
}
