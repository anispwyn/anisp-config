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
}
