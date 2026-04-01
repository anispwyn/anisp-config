{
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.niri.homeModules.niri];
  programs.niri = {
    package = pkgs.niri-unstable;
    enable = true;
    settings = {
      xwayland-satellite.enable = true;
      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite-unstable;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      hotkey-overlay.skip-at-startup = true;
      clipboard.disable-primary = true;

      environment = {
        XDG_CURRENT_DESKTOP = "niri";
      };
      gestures.hot-corners.enable = false;
      prefer-no-csd = true;
      layout = {
        background-color = "transparent";
        center-focused-column = "never";

        preset-column-widths = [
          {proportion = 0.33333;}
          {proportion = 0.5;}
          {proportion = 0.66667;}
        ];
        default-column-width.proportion = 0.5;
        shadow.enable = false;
        focus-ring.enable = false;
        border.enable = false;
        # struts = {
        #   top = 0;
        #   bottom = 0;
        #   left = 4;
        #   right = 4;
        # };
        gaps = 0;
      };
      overview.workspace-shadow.enable = false;
      layer-rules = [
        {
          matches = [{namespace = "^quickshell$";}];
          place-within-backdrop = true;
        }
      ];

      window-rules = [
        {
          matches = [{app-id = "^org\\.wezfurlong\\.wezterm$";}];
          default-column-width = {};
        }
        {
          matches = [{app-id = "^org\\.gnome\\.";}];
          draw-border-with-background = false;
          geometry-corner-radius = let
            r = 12.0;
          in {
            top-left = r;
            top-right = r;
            bottom-left = r;
            bottom-right = r;
          };
          clip-to-geometry = true;
        }
        {
          matches = [
            {app-id = "^gnome-control-center$";}
            {app-id = "^pavucontrol$";}
            {app-id = "^nm-connection-editor$";}
          ];
          default-column-width.proportion = 0.5;
          open-floating = false;
        }
        {
          matches = [
            {app-id = "^gnome-calculator$";}
            {app-id = "^galculator$";}
            {app-id = "^blueman-manager$";}
            {app-id = "^org\\.gnome\\.Nautilus$";}
            {app-id = "^steam$";}
            {app-id = "^xdg-desktop-portal$";}
          ];
          open-floating = true;
        }
        {
          matches = [
            {app-id = "^org\\.wezfurlong\\.wezterm$";}
            {app-id = "Alacritty";}
            {app-id = "zen-twilight";}
            {app-id = "com.mitchellh.ghostty";}
            {app-id = "kitty";}
          ];
          draw-border-with-background = false;
        }
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture$";
            }
            {app-id = "zoom";}
          ];
          open-floating = true;
        }
        {
          matches = [{app-id = "org.quickshell$";}];
          open-floating = true;
        }
      ];

      debug = {
        honor-xdg-activation-with-invalid-serial = [];
      };
      animations = {
        workspace-switch.kind.spring = {
          damping-ratio = 0.80;
          stiffness = 523;
          epsilon = 0.0001;
        };
        window-open.kind.easing = {
          curve = "ease-out-expo";
          duration-ms = 150;
        };
        window-close.kind.easing = {
          curve = "ease-out-quad";
          duration-ms = 150;
        };
        horizontal-view-movement.kind.spring = {
          damping-ratio = 0.85;
          stiffness = 423;
          epsilon = 0.0001;
        };
        window-movement.kind.spring = {
          damping-ratio = 0.75;
          stiffness = 323;
          epsilon = 0.0001;
        };
        window-resize.kind.spring = {
          damping-ratio = 0.85;
          stiffness = 423;
          epsilon = 0.0001;
        };
        config-notification-open-close.kind.spring = {
          damping-ratio = 0.65;
          stiffness = 923;
          epsilon = 0.001;
        };
        screenshot-ui-open.kind.easing = {
          curve = "ease-out-quad";
          duration-ms = 200;
        };
        overview-open-close.kind.spring = {
          damping-ratio = 0.85;
          stiffness = 800;
          epsilon = 0.0001;
        };
      };
      input = {
        focus-follows-mouse.enable = true;
        touchpad = {
          tap = true;
          natural-scroll = true;
        };
        keyboard = {
          repeat-rate = 100;
          repeat-delay = 200;
          xkb = {
            layout = "us,th";
            options = "grp:alt_shift_toggle";
          };
        };
      };

      binds = {
        "Mod+T" = {
          action.spawn = "ghostty";
          hotkey-overlay.title = "Open Terminal";
        };
        "Mod+B".action.spawn = "vivaldi";

        "Mod+Space" = {
          action.spawn = ["dms" "ipc" "call" "spotlight" "toggle"];
          hotkey-overlay.title = "Application Launcher";
        };
        "Mod+V" = {
          action.spawn = ["dms" "ipc" "call" "clipboard" "toggle"];
          hotkey-overlay.title = "Clipboard Manager";
        };
        "Mod+M" = {
          action.spawn = ["dms" "ipc" "call" "processlist" "toggle"];
          hotkey-overlay.title = "Task Manager";
        };
        "Ctrl+Alt+Delete" = {
          action.spawn = ["dms" "ipc" "call" "processlist" "toggle"];
          hotkey-overlay.title = "Task Manager";
        };
        "Mod+Comma" = {
          action.spawn = ["dms" "ipc" "call" "settings" "toggle"];
          hotkey-overlay.title = "Settings";
        };
        "Mod+Y" = {
          action.spawn = ["dms" "ipc" "call" "dankdash" "wallpaper"];
          hotkey-overlay.title = "Browse Wallpapers";
        };
        "Mod+N" = {
          action.spawn = ["dms" "ipc" "call" "notifications" "toggle"];
          hotkey-overlay.title = "Notification Center";
        };
        "Mod+Shift+N" = {
          action.spawn = ["dms" "ipc" "call" "notepad" "toggle"];
          hotkey-overlay.title = "Notepad";
        };

        "Mod+D".action.spawn = ["niri" "msg" "action" "toggle-overview"];
        "Mod+Tab" = {
          action.toggle-overview = [];
          repeat = false;
        };
        "Mod+Shift+Slash".action.show-hotkey-overlay = [];
        "Mod+Shift+E".action.quit = [];

        "Mod+Alt+L" = {
          action.spawn = ["dms" "ipc" "call" "lock" "lock"];
          hotkey-overlay.title = "Lock Screen";
        };

        "XF86AudioRaiseVolume" = {
          action.spawn = ["dms" "ipc" "call" "audio" "increment" "3"];
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action.spawn = ["dms" "ipc" "call" "audio" "decrement" "3"];
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action.spawn = ["dms" "ipc" "call" "audio" "mute"];
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action.spawn = ["dms" "ipc" "call" "audio" "micmute"];
          allow-when-locked = true;
        };
        "XF86AudioPlay" = {
          action.spawn = ["playerctl" "-i" "kdeconnect" "play-pause"];
          allow-when-locked = true;
        };
        "XF86AudioPrev" = {
          action.spawn = ["playerctl" "-i" "kdeconnect" "previous"];
          allow-when-locked = true;
        };
        "XF86AudioNext" = {
          action.spawn = ["playerctl" "-i" "kdeconnect" "next"];
          allow-when-locked = true;
        };

        "XF86MonBrightnessUp" = {
          action.spawn = ["dms" "ipc" "call" "brightness" "increment" "5" ""];
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action.spawn = ["dms" "ipc" "call" "brightness" "decrement" "5" ""];
          allow-when-locked = true;
        };

        "Mod+Q" = {
          action.close-window = [];
          repeat = false;
        };
        "Mod+F".action.maximize-column = [];
        "Mod+Shift+F".action.fullscreen-window = [];
        "Mod+Shift+T".action.toggle-window-floating = [];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [];
        "Mod+W".action.toggle-column-tabbed-display = [];

        "Mod+Left".action.focus-column-left = [];
        "Mod+Down".action.focus-window-down = [];
        "Mod+Up".action.focus-window-up = [];
        "Mod+Right".action.focus-column-right = [];
        "Mod+H".action.focus-column-left = [];
        "Mod+J".action.focus-window-down = [];
        "Mod+K".action.focus-window-up = [];
        "Mod+L".action.focus-column-right = [];

        "Mod+Shift+Left".action.move-column-left = [];
        "Mod+Shift+Down".action.move-window-down = [];
        "Mod+Shift+Up".action.move-window-up = [];
        "Mod+Shift+Right".action.move-column-right = [];
        "Mod+Shift+H".action.move-column-left = [];
        "Mod+Shift+J".action.move-window-down = [];
        "Mod+Shift+K".action.move-window-up = [];
        "Mod+Shift+L".action.move-column-right = [];

        "Mod+Home".action.focus-column-first = [];
        "Mod+End".action.focus-column-last = [];
        "Mod+Ctrl+Home".action.move-column-to-first = [];
        "Mod+Ctrl+End".action.move-column-to-last = [];

        "Mod+Ctrl+Left".action.focus-monitor-left = [];
        "Mod+Ctrl+Right".action.focus-monitor-right = [];
        "Mod+Ctrl+H".action.focus-monitor-left = [];
        "Mod+Ctrl+J".action.focus-monitor-down = [];
        "Mod+Ctrl+K".action.focus-monitor-up = [];
        "Mod+Ctrl+L".action.focus-monitor-right = [];

        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [];
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [];
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [];
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [];
        "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = [];
        "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = [];
        "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = [];
        "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = [];

        "Mod+Page_Down".action.focus-workspace-down = [];
        "Mod+Page_Up".action.focus-workspace-up = [];
        "Mod+U".action.focus-workspace-down = [];
        "Mod+I".action.focus-workspace-up = [];
        "Mod+Ctrl+Down".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+Up".action.move-column-to-workspace-up = [];
        "Mod+Ctrl+U".action.move-column-to-workspace-down = [];
        "Mod+Ctrl+I".action.move-column-to-workspace-up = [];

        "Mod+Shift+Page_Down".action.move-workspace-down = [];
        "Mod+Shift+Page_Up".action.move-workspace-up = [];
        "Mod+Shift+U".action.move-workspace-down = [];
        "Mod+Shift+I".action.move-workspace-up = [];

        "Mod+WheelScrollDown" = {
          action.focus-workspace-down = [];
          cooldown-ms = 150;
        };
        "Mod+WheelScrollUp" = {
          action.focus-workspace-up = [];
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollDown" = {
          action.move-column-to-workspace-down = [];
          cooldown-ms = 150;
        };
        "Mod+Ctrl+WheelScrollUp" = {
          action.move-column-to-workspace-up = [];
          cooldown-ms = 150;
        };
        "Mod+WheelScrollRight".action.focus-column-right = [];
        "Mod+WheelScrollLeft".action.focus-column-left = [];
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = [];
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [];
        "Mod+Shift+WheelScrollDown".action.focus-column-right = [];
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [];
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [];
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [];

        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;

        "Mod+Shift+1".action.move-column-to-workspace = 1;
        "Mod+Shift+2".action.move-column-to-workspace = 2;
        "Mod+Shift+3".action.move-column-to-workspace = 3;
        "Mod+Shift+4".action.move-column-to-workspace = 4;
        "Mod+Shift+5".action.move-column-to-workspace = 5;
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = 7;
        "Mod+Shift+8".action.move-column-to-workspace = 8;
        "Mod+Shift+9".action.move-column-to-workspace = 9;

        "Mod+BracketLeft".action.consume-or-expel-window-left = [];
        "Mod+BracketRight".action.consume-or-expel-window-right = [];
        "Mod+Period".action.expel-window-from-column = [];

        "Mod+R".action.switch-preset-column-width = [];
        "Mod+Shift+R".action.switch-preset-window-height = [];
        "Mod+Ctrl+R".action.reset-window-height = [];
        "Mod+Ctrl+F".action.expand-column-to-available-width = [];
        "Mod+C".action.center-column = [];
        "Mod+Ctrl+C".action.center-visible-columns = [];

        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "+10%";
        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        "Mod+Shift+S".action.screenshot = [];
        "XF86Launch1".action.screenshot-screen = [];

        "Alt+XF86Launch1".action.spawn = ["niri" "msg" "action" "screenshot-window"];

        "Print".action.screenshot-screen = [];
        "Ctrl+Print".action.screenshot-screen = [];

        "Alt+Print".action.spawn = ["niri" "msg" "action" "screenshot-window"];

        "Mod+Escape" = {
          action.toggle-keyboard-shortcuts-inhibit = [];
          allow-inhibiting = false;
        };
        "Mod+Shift+P".action.power-off-monitors = [];
      };
    };
  };
}
