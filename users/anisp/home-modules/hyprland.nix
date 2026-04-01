{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {
      source = [
        "~/.config/hypr/dms/colors.conf"
        "~/.config/hypr/dms/cursor.conf"
        "~/.config/hypr/dms/layout.conf"
        "~/.config/hypr/dms/outputs.conf"
        "~/.config/hypr/dms/windowrules.conf"
      ];
      # ── Environment ────────────────────────────────────────────────────
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
      ];

      # ── General ────────────────────────────────────────────────────────
      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 0;
        layout = "scrolling"; # native since Hyprland 0.54
      };

      # ── Scrolling layout ───────────────────────────────────────────────
      scrolling = {
        column_width = 0.5; # Niri: default-column-width.proportion = 0.5
        explicit_column_widths = "0.333, 0.5, 0.667"; # Niri: preset-column-widths
        focus_fit_method = 1; # 1 = fit (Niri: center-focused-column = "never")
        follow_focus = true;
        fullscreen_on_one_column = false;
      };

      # ── Decoration ─────────────────────────────────────────────────────
      decoration = {
        rounding = 0;
        shadow.enabled = false;
        blur.enabled = false;
      };

      # ── Input ──────────────────────────────────────────────────────────
      input = {
        follow_mouse = 1;
        kb_layout = "us,th";
        kb_options = "grp:alt_shift_toggle";
        repeat_rate = 100;
        repeat_delay = 200;
        touchpad = {
          tap-to-click = true;
          natural_scroll = true;
        };
      };

      # ── Gestures ───────────────────────────────────────────────────────
      # workspace_swipe/workspace_swipe_fingers removed in 0.51, use gesture keyword
      gesture = [
        "3, horizontal, workspace"
      ];

      # ── Misc ───────────────────────────────────────────────────────────
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      # ── Animations ─────────────────────────────────────────────────────
      animations = {
        enabled = true;
        bezier = [
          "workspaceSwitch, 0.16, 1, 0.3, 1"
          "windowOpen, 0.16, 1, 0.3, 1"
          "windowClose, 0.25, 1, 0.5, 1"
          "windowMove, 0.2, 1, 0.35, 1"
        ];
        animation = [
          "workspaces, 1, 4, workspaceSwitch, slide"
          "windows, 1, 2, windowOpen, popin 80%"
          "windowsOut, 1, 2, windowClose, popin 80%"
          "windowsMove, 1, 3, windowMove"
          "fade, 1, 3, default"
          "border, 0, 1, default"
          "layers, 1, 2, windowOpen, popin 80%"
        ];
      };

      # ── Layer rules ────────────────────────────────────────────────────
      layerrule = [
        "no_anim on, match:namespace ^quickshell$"
      ];

      # ── Window rules ───────────────────────────────────────────────────
      # New windowrule syntax (windowrulev2 deprecated since 0.45+)
      # Format: windowrule = match:prop regex, effect value
      windowrule = [
        # GNOME apps: rounded corners (Niri: geometry-corner-radius = 12)
        "match:class ^(org\\.gnome\\..*)$, rounding 12"

        # Float (Niri: open-floating = true)
        "match:class ^(gnome-calculator)$, float true"
        "match:class ^(galculator)$, float true"
        "match:class ^(blueman-manager)$, float true"
        "match:class ^(org\\.gnome\\.Nautilus)$, float true"
        "match:class ^(steam)$, float true"
        "match:class ^(xdg-desktop-portal)$, float true"
        "match:class ^(org\\.quickshell)$, float true"
        "match:class ^(zoom)$, float true"

        # Firefox PiP
        "match:class ^(firefox)$, match:title ^(Picture-in-Picture)$, float true"
      ];

      # ── Keybinds ───────────────────────────────────────────────────────
      "$mod" = "SUPER";

      bind = [
        # ── Apps ─────────────────────────────────────────────────────────
        "$mod, T,          exec, ghostty"
        "$mod, B,          exec, zen-twilight"
        "$mod, SPACE,      exec, dms ipc call spotlight toggle"
        "$mod, V,          exec, dms ipc call clipboard toggle"
        "$mod, M,          exec, dms ipc call processlist toggle"
        "CTRL ALT, Delete, exec, dms ipc call processlist toggle"
        "$mod, comma,      exec, dms ipc call settings toggle"
        "$mod, Y,          exec, dms ipc call dankdash wallpaper"
        "$mod, N,          exec, dms ipc call notifications toggle"
        "$mod SHIFT, N,    exec, dms ipc call notepad toggle"

        # ── WM ───────────────────────────────────────────────────────────
        "$mod SHIFT, E, exit,"
        "$mod ALT, L,   exec, dms ipc call lock lock"
        "$mod SHIFT, P, dpms, off"

        # ── Window management ─────────────────────────────────────────────
        "$mod, Q,       killactive,"
        "$mod, F,       fullscreen, 1"
        "$mod SHIFT, F, fullscreen, 0"
        "$mod SHIFT, T, togglefloating,"

        # ── Focus movement ────────────────────────────────────────────────
        "$mod, left,  layoutmsg, focus l"
        "$mod, right, layoutmsg, focus r"
        "$mod, H,     layoutmsg, focus l"
        "$mod, L,     layoutmsg, focus r"
        "$mod, up,    movefocus, u"
        "$mod, down,  movefocus, d"
        "$mod, K,     movefocus, u"
        "$mod, J,     movefocus, d"

        "$mod, Home, layoutmsg, focus beginning"
        "$mod, End,  layoutmsg, focus end"

        # ── Move windows/columns ──────────────────────────────────────────
        "$mod SHIFT, left,  layoutmsg, swapcol l"
        "$mod SHIFT, right, layoutmsg, swapcol r"
        "$mod SHIFT, H,     layoutmsg, swapcol l"
        "$mod SHIFT, L,     layoutmsg, swapcol r"
        "$mod SHIFT, up,    layoutmsg, movewindowto u"
        "$mod SHIFT, down,  layoutmsg, movewindowto d"
        "$mod SHIFT, K,     layoutmsg, movewindowto u"
        "$mod SHIFT, J,     layoutmsg, movewindowto d"

        # ── Column sizing ─────────────────────────────────────────────────
        "$mod, R,           layoutmsg, colresize +conf"
        "$mod SHIFT, R,     layoutmsg, colresize -conf"
        "$mod, minus,       layoutmsg, colresize -0.1"
        "$mod, equal,       layoutmsg, colresize +0.1"
        "$mod SHIFT, minus, resizeactive, 0 -80"
        "$mod SHIFT, equal, resizeactive, 0 80"
        "$mod CTRL, F,      layoutmsg, fit active"
        "$mod, C,           layoutmsg, togglefit"

        # ── Consume / expel ───────────────────────────────────────────────
        "$mod, BracketLeft,  layoutmsg, promote"
        "$mod, BracketRight, layoutmsg, promote"
        "$mod, Period,       layoutmsg, promote"

        # ── Workspace switching ───────────────────────────────────────────
        "$mod, Page_Down, workspace, e+1"
        "$mod, Page_Up,   workspace, e-1"
        "$mod, U,         workspace, e+1"
        "$mod, I,         workspace, e-1"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        # Move entire column to workspace
        "$mod CTRL, down, layoutmsg, movecoltoworkspace e+1"
        "$mod CTRL, up,   layoutmsg, movecoltoworkspace e-1"
        "$mod CTRL, U,    layoutmsg, movecoltoworkspace e+1"
        "$mod CTRL, I,    layoutmsg, movecoltoworkspace e-1"

        # ── Monitor focus / move ──────────────────────────────────────────
        "$mod CTRL, H,     focusmonitor, l"
        "$mod CTRL, L,     focusmonitor, r"
        "$mod CTRL, J,     focusmonitor, d"
        "$mod CTRL, K,     focusmonitor, u"
        "$mod CTRL, left,  focusmonitor, l"
        "$mod CTRL, right, focusmonitor, r"

        "$mod SHIFT CTRL, H,     movewindow, mon:l"
        "$mod SHIFT CTRL, L,     movewindow, mon:r"
        "$mod SHIFT CTRL, J,     movewindow, mon:d"
        "$mod SHIFT CTRL, K,     movewindow, mon:u"
        "$mod SHIFT CTRL, left,  movewindow, mon:l"
        "$mod SHIFT CTRL, right, movewindow, mon:r"
        "$mod SHIFT CTRL, up,    movewindow, mon:u"
        "$mod SHIFT CTRL, down,  movewindow, mon:d"

        # ── Screenshots ───────────────────────────────────────────────────
        "$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        ", Print,      exec, grim - | wl-copy"
        "CTRL, Print,  exec, grim - | wl-copy"
        "ALT, Print,   exec, grim -g \"$(hyprctl activewindow -j | jq -r '\"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])\"')\" - | wl-copy"

        # ── Mouse scroll ──────────────────────────────────────────────────
        "$mod, mouse_down,       workspace, e+1"
        "$mod, mouse_up,         workspace, e-1"
        "$mod CTRL, mouse_down,  layoutmsg, movecoltoworkspace e+1"
        "$mod CTRL, mouse_up,    layoutmsg, movecoltoworkspace e-1"
        "$mod SHIFT, mouse_down, layoutmsg, focus r"
        "$mod SHIFT, mouse_up,   layoutmsg, focus l"
        "$mod, mouse_right,      layoutmsg, focus r"
        "$mod, mouse_left,       layoutmsg, focus l"
      ];

      # Lock screen passthrough (Niri: allow-when-locked = true)
      bindl = [
        ", XF86AudioRaiseVolume,  exec, dms ipc call audio increment 3"
        ", XF86AudioLowerVolume,  exec, dms ipc call audio decrement 3"
        ", XF86AudioMute,         exec, dms ipc call audio mute"
        ", XF86AudioMicMute,      exec, dms ipc call audio micmute"
        ", XF86AudioPlay,         exec, playerctl -i kdeconnect play-pause"
        ", XF86AudioPrev,         exec, playerctl -i kdeconnect previous"
        ", XF86AudioNext,         exec, playerctl -i kdeconnect next"
        ", XF86MonBrightnessUp,   exec, dms ipc call brightness increment 5"
        ", XF86MonBrightnessDown, exec, dms ipc call brightness decrement 5"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
