{inputs, ...}: {
  imports = [inputs.nix-flatpak.homeManagerModules.nix-flatpak];
  services.flatpak = {
    update.onActivation = true;
    uninstallUnmanaged = true;
    packages = ["org.vinegarhq.Sober"];
    overrides = {
      writeMode = "replace";
      settings = {
        global = {
          Context.sockets = ["wayland" "!x11" "!fallback-x11"];
          Environment = {
            # Fix un-themed cursor in some Wayland apps
            XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
          };
        };
        "org.vinegarhq.Sober".Context.filesystems = ["xdg-run/app/com.discordapp.Discord:create" "xdg-run/discord-ipc-0"];
      };
    };
  };
}
