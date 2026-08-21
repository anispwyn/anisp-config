{pkgs, ...}: {
  imports = [
    ./nixosModules
  ];
  boot = {
    kernelParams = ["idle=poll"];
    kernelPackages = pkgs.linuxPackages_testing;
  };

  networking.hostName = "cutie";

  time.timeZone = "Asia/Bangkok";

  services = {
    xserver = {
      videoDrivers = ["nvidia"];
    };
  };
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      open = true;
      branch = "bleeding_edge";
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
    extraGroups = [
      "libvirtd"
      "wheel"
      "networkmanager"
      "input"
      "podman"
      "docker"
      "audio" # musnix
    ];
    openssh = {
      authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHDiVWG/LvNyd46LYg3aqCEqXOdMVxGAO+lMY5Je65m"];
    };
  };
  environment = {
    # etc."systemd/resolved.conf.d/nextdns.conf".source = config.sops.templates."resolved-nextdns".path;
    systemPackages = with pkgs; [
      omen-fan
      mcp-nixos
      (steam.override {
        extraLibraries = p:
          with p; [
            xdg-utils
            libxscrnsaver
            libXxf86vm
            nspr
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
      package = pkgs.steam.override {
        extraLibraries = p:
          with p; [
            libxscrnsaver
          ];
      };
    };
    gamemode.enable = true;
  };

  system.stateVersion = "25.11";
}
