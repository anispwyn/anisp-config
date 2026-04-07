{
  pkgs,
  lib,
  config,
  ...
}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
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
      substituters = ["https://niri.cachix.org" "https://ezkea.cachix.org" "https://nix-community.cachix.org" "https://cache.nixos-cuda.org" "https://attic.xuyh0120.win/lantian" "https://nix-gaming.cachix.org" "https://cache.garnix.io" "https://helium-dev.cachix.org" "https://nix-citizen.cachix.org"];
      trusted-public-keys = ["niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" "helium-dev.cachix.org-1:dpzYcGK9ck6V16XyiAClKHpdSUrz6U9uvEWgUP9FMYg=" "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="];
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
    soteria.enable = true;
  };
  services = {
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
    };
  };

  programs = {
    fish.enable = true;
    ssh.askPassword = pkgs.lib.mkForce "${pkgs.kdePackages.ksshaskpass.out}/bin/ksshaskpass";
    ssh.enableAskPassword = true;
    gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
      enableSSHSupport = true;
    };
  };
  networking = {
    nftables.enable = true;
    networkmanager = {
      enable = true;
    };
    firewall = {
      enable = true;
      trustedInterfaces = lib.optionals config.services.tailscale.enable ["tailscale0"];
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
      googlesans-code
    ];
  };

  environment = {
    pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [
      gnupg1
      xdg-utils
      fzf
      bat
      ripgrep
      git
      wget
    ];
  };
}
