{
  programs = {
    ghostty = {
      enable = true;
      systemd = {
        enable = true;
      };
      installBatSyntax = true;
      installVimSyntax = true;
      settings = {
        language = "en";
        cursor-click-to-move = true;
        mouse-hide-while-typing = true;
        notify-on-command-finish = "unfocused";
        notify-on-command-finish-after = "2m";
        link-previews = true;
        window-padding-x = 0;
        window-padding-y = 0;
        window-inherit-working-directory = false;
        tab-inherit-working-directory = true;
        split-inherit-working-directory = true;
        focus-follows-mouse = true;
        clipboard-write = "allow";
        quick-terminal-position = "top";
        gtk-quick-terminal-layer = "overlay";
        async-backend = "io_uring";
        auto-update = "off";
        cursor-style = "block";
      };
    };
    foot = {
      enable = true;
      settings = {
        main.shell = "zellij -l welcome attach --create welcome"; # idk how and where this come from
      };
    };
    fish = {
      enable = true;
      interactiveShellInit = ''
        functions -c fish_prompt _original_fish_prompt 2>/dev/null
        function fish_prompt --description "Write out the prompt"
          if set -q ZMX_SESSION
            echo -n "[$ZMX_SESSION] "
          end
          _original_fish_prompt
        end
      '';
    };
    zellij = {
      enable = true;
      settings = {
        simplified_ui = true;
        pane_frames = false;
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
