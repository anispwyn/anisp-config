{
  pkgs,
  lib,
  config,
  ...
}: {
  boot = {
    loader = {
      systemd-boot.enable =
        if config.boot.lanzaboote.enable
        then false
        else true;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

  nixpkgs = {
    overlays = [
      (final: prev: {
        inherit
          (prev.lixPackageSets.latest)
          nixpkgs-review
          nix-eval-jobs
          nix-fast-build
          colmena
          ;
      })
    ];
  };
  nix = {
    package = pkgs.lixPackageSets.latest.lix;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["anisp"];
      substituters = ["https://niri-epireyn.cachix.org" "https://ezkea.cachix.org" "https://nix-community.cachix.org" "https://cache.nixos-cuda.org" "https://cache.numtide.com"];
      trusted-public-keys = ["niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA=" "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="];
    };
  };

  hardware = {
    keyboard = {
      qmk.enable = true;
    };
  };
  security = {
    rtkit.enable = true;
    polkit = {
      enable = true;
    };
  };
  services = {
    nohang.enable = true;
    resolved = {
      enable = true;
    };
    accounts-daemon.enable = true;
    power-profiles-daemon.enable = true;
    fwupd.enable = true;
    pipewire = {
      enable = true;
      wireplumber = {
        enable = true;
      };
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = lib.mkIf config.musnix.enable true;
    };
  };

  xdg = {
    portal = {
      enable = true;
      configPackages = [pkgs.gnome-session];
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };

  programs = {
    fish.enable = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
      enableSSHSupport = true;
    };
    virt-manager.enable = config.virtualisation.libvirtd.enable;
  };
  networking = {
    nftables.enable = true;
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      trustedInterfaces = lib.optionals config.services.tailscale.enable ["tailscale0"] ++ lib.optionals config.virtualisation.libvirtd.enable ["virbr0"];
      allowedUDPPorts = lib.optional config.services.tailscale.enable config.services.tailscale.port;
      # kdeconnect both udp and tcp
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };
  };
  systemd = {
    services = {
      tailscaled.serviceConfig.Environment = [
        "TS_DEBUG_FIREWALL_MODE=nftables"
      ];
    };
    network.wait-online.enable = false;
  };
  boot.initrd.systemd.network.wait-online.enable = false;

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts.sansSerif = ["Noto Sans Thai"];
    };
    packages = with pkgs; [
      noto-fonts
      google-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      googlesans-code-nerd
    ];
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = 1;
    pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; ([
        gnupg1
        xdg-utils
        fzf
        bat
        jq
        ripgrep
        git
        wget
      ]
      ++ lib.optionals config.virtualisation.libvirtd.enable [pkgs.dnsmasq]);
  };
}
