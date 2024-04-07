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
      exec-once = ''${startupScript}/bin/start'';
      general = {
        layout = "master";
        gaps_in = 5;
        gaps_out = 10;
      };
      xwayland.force_zero_scaling = true;
      debug.watchdog_timeout = 0;
      "$mainMod" = "SUPER";
      decoration = {
        rounding = "12";
        blur.enabled = false;
        drop_shadow = true;
        shadow_range = 16;
        shadow_render_power = 3;
        shadow_offset = "2 2";
        "col.shadow" = "rgba(0C0E13A0)";
        dim_special = "0.35";
      };

      bind = [
        ''CTRL ALT, Return, exec, ${pkgs.kitty}/bin/kitty''
        ''$mainMod, D, exec, ${pkgs.wofi}/bin/wofi -show drun -show-icons''
        ''$mainMod, Tab, focusmonitor, +1''
        ''$mainMod CTRL, P, exec, ${waybarRestart}/bin/restart''
        ''$mainMod CTRL, R, exec, hyprctl reload''
        ''$mainMod SHIFT, Tab, focusmonitor, -1''
        ''CTRL ALT SHIFT, S, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" ~/Pictures/Screenshots/$(date +'%s_grim.png')''
        ''CTRL ALT, S, exec, ${pkgs.grim}/bin/grim -l 0 -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy''
        '', XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_SINK@ 5%-''
        '', XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_SINK@ 5%+''
        '', XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle''
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
      ];
      bindm = [
        ''$mainMod, mouse:272, movewindow''
        ''$mainMod, mouse:273, resizewindow''
      ];
    };
  };
}
