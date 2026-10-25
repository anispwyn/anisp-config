{inputs, ...}: {
  imports = [inputs.nix-index-database.homeModules.default];
  # common programs goes here
  programs = {
    mangohud = {
      enable = true;
    };
    nix-index-database.comma.enable = true;
    nix-index.enable = true;
    gpg = {
      enable = true;
      settings = {
        pinentry-mode = "loopback";
      };
    };
  };
}
