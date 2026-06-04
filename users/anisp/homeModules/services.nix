{
  # common services goes here
  services = {
    easyeffects = {enable = true;};
    kdeconnect = {enable = true;};
    gpg-agent = {
      enable = true;
      extraConfig = ''
        allow-loopback-pinentry
      '';
    };
  };
}
