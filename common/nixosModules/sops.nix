{
  inputs,
  config,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    defaultSopsFile = ../../secrets/anisp.yaml;

    age.keyFile = "/var/lib/sops/keys.txt";
    age.generateKey = true;

    secrets = {
      nextdns_profile = {};
      wifi_ssid_name = {};
      wifi_username = {};
      wifi_password = {};
      hermes-secret = {format = "yaml";};
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
    };
  };
}
