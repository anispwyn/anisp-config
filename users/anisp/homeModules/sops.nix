{
  inputs,
  config,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    defaultSopsFile = ../../../secrets/anisp.yaml;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/keys.txt";
    age.generateKey = true;

    secrets = {
      lastfm_api_key = {};
    };
  };
}
