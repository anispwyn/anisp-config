{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nixcord.url = "github:FlameFlag/nixcord";
    nix-gaming.url = "github:fufexan/nix-gaming";
    flakelight.url = "github:nix-community/flakelight";
    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs.nix-gaming.follows = "nix-gaming";
    };
    animesteam = {
      url = "github:an-anime-team/anime-games-launcher/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zmx = {
      url = "github:neurosnap/zmx";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tt-schemes = {
      url = "github:tinted-theming/schemes";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {flakelight, ...} @ inputs:
    flakelight ./. {
      systems = ["x86_64-linux"];
      nixDirAliases.nixosConfigurations = ["nixos"];
      nixpkgs = {
        config = {
          cudaSupport = true;
          allowUnfree = true;
        };
      };
      withOverlays = [
        inputs.niri.overlays.niri
        inputs.nix-cachyos-kernel.overlays.pinned
        inputs.firefox-addons.overlays.default
      ];
      formatters = pkgs: {
        "*.nix" = "${pkgs.lib.getExe pkgs.alejandra} .";
        "*.yml" = "${pkgs.lib.getExe pkgs.oxfmt} --wrtie '*.yml'";
        "*.yaml" = "${pkgs.lib.getExe pkgs.oxfmt} --wrtie '*.yaml'";
      };
    };
}
