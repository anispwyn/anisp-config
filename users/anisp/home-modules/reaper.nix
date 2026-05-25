{pkgs, ...}: {
  xdg.configFile = {
    "REAPER" = {
      enable = true;
      source = pkgs.symlinkJoin {
        name = "reaper-plugins";
        paths = with pkgs; [
          reaper-reapack-extension
          reaper-sws-extension
        ];
      };
      recursive = true;
      force = true;
    };
  };
}
