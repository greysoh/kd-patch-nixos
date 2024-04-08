{
  pkgs,
  lib,
  inputs,
  ...
}: let
  startupScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.mako}/bin/mako &
    ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
    ${pkgs.swww}/bin/swww-daemon &
    sleep 1
    ${pkgs.swww}/bin/swww img ${./wallpaper.jpg} &
  '';
  waybarRestart = pkgs.writeShellScriptBin "restart" ''
    ${pkgs.procps}/bin/pkill -9 -f waybar
    ${pkgs.waybar}/bin/waybar &
  '';
in {
  wayland.windowManager.hyprland = {
    # allow home-manager to configure hyprland
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;

    settings = {
      misc = {
        vfr = true;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        disable_autoreload = true;
        background_color = "rgb(000000)";
        focus_on_activate = false;
        new_window_takes_over_fullscreen = 2;
      };
      exec-once = [
        ''${startupScript}/bin/start''
        ''dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP''
      ];
      general = {
        layout = "master";
        gaps_in = 5;
        gaps_out = 10;
      };
      xwayland.force_zero_scaling = true;
      debug.watchdog_timeout = 0;
      input = {
        sensitivity = 0;
        force_no_accel = 1;
      };
      "$mainMod" = "SUPER";
      decoration = {
        rounding = "12";
        blur.enabled = false;
        drop_shadow = false;
        shadow_range = 16;
        shadow_render_power = 3;
        shadow_offset = "2 2";
        "col.shadow" = "rgba(0C0E13A0)";
        dim_special = "0.35";
      };
      animations = {
        enabled = true;
        first_launch_animation = false;

        bezier = "overshot,0.5,0.1,0.4,1.2";
        animation = [
          "global, 1, 3, default"
          "workspaces, 1, 4, default"
          "windowsMove, 1, 2, default"
          "fade, 1, 2, default"
        ];
      };
      layerrule = [
        "animation slide, notifications"
      ];
      windowrule = [
        "float,^(kitty)$"
      ];

      bind = [
        ''CTRL ALT, Return, exec, ${pkgs.kitty}/bin/kitty''
        ''$mainMod, D, exec, ${pkgs.wofi}/bin/wofi --show drun --show-icons''
        ''$mainMod, Tab, focusmonitor, +1''
        ''$mainMod ALT, P, exec, ${waybarRestart}/bin/restart''
        ''$mainMod ALT, R, exec, hyprctl reload''
        ''$mainMod ALT, X, exec, pkill Hyprland''
        #zoom??
        ''SUPER, Z, exec, hyprctl keyword misc:cursor_zoom_factor 4''
        ''SUPER SHIFT, Z, exec, hyprctl keyword misc:cursor_zoom_factor 1''
        ''$mainMod SHIFT, Tab, focusmonitor, -1''
        ''CTRL ALT SHIFT, S, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" ~/Pictures/Screenshots/$(date +'%s_grim.png')''
        ''CTRL ALT, S, exec, ${pkgs.grim}/bin/grim -l 0 -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy''
        '', XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_SINK@ 5%-''
        '', XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_SINK@ 5%+''
        '', XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle''
        '', XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle''
        # workspaces
        ''$mainMod, 1, workspace, 1''
        ''$mainMod, 2, workspace, 2''
        ''$mainMod, 3, workspace, 3''
        ''$mainMod, 4, workspace, 4''
        ''$mainMod, 5, workspace, 5''
        ''$mainMod, 6, workspace, 6''
        ''$mainMod, 7, workspace, 7''
        ''$mainMod, 8, workspace, 8''
        ''$mainMod, 9, workspace, 9''
        ''$mainMod, 0, workspace, 10''
        ''$mainMod SHIFT, 1, movetoworkspace, 1''
        ''$mainMod SHIFT, 2, movetoworkspace, 2''
        ''$mainMod SHIFT, 3, movetoworkspace, 3''
        ''$mainMod SHIFT, 4, movetoworkspace, 4''
        ''$mainMod SHIFT, 5, movetoworkspace, 5''
        ''$mainMod SHIFT, 6, movetoworkspace, 6''
        ''$mainMod SHIFT, 7, movetoworkspace, 7''
        ''$mainMod SHIFT, 8, movetoworkspace, 8''
        ''$mainMod SHIFT, 9, movetoworkspace, 9''
        ''$mainMod SHIFT, 0, movetoworkspace, 10''
        ''$mainMod, K, movefocus, u''
        ''$mainMod, H, movefocus, l''
        ''$mainMod, J, movefocus, d''
        ''$mainMod, L, movefocus, r''
        ''SUPER, F, fullscreen,''
        ''SUPER SHIFT, F, fullscreen, 2'' # just change window size
        ''SUPER ALT, F, fakefullscreen,'' # Just change fullscreen state
        ''SUPER, G, togglefloating,''
        ''SUPER, P, pseudo,''
        ''SUPER SHIFT, P, pin,''
        ''SUPER, T, togglesplit,''
        ''SUPER, U, focusurgentorlast,''
        ''SUPER, Q, killactive,''
      ];
      bindm = [
        ''$mainMod, mouse:272, movewindow''
        ''$mainMod, mouse:273, resizewindow''
      ];
    };
  };
}
