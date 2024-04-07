{
  pkgs,
  lib,
  inputs,
  ...
}: let
  startupScript = pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &
    sleep 1
    ${pkgs.swww}/bin/swww img ${./wallpaper.jpg} &
  '';
  waybarRestart = pkgs.writeShellScriptBin "waybarrestart" ''
    killall waybar
    ${pkgs.waybar}/bin/waybar &
  '';
in {
  wayland.windowManager.hyprland = {
    # allow home-manager to configure hyprland
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;

    settings = {
      exec-once = ''${startupScript}/bin/start'';
      general.layout = "master";
      "$mainMod" = "SUPER";
      "$terminal" = "wezterm";

      bind = [
        ''$mainMod, Return, exec, $terminal''
        ''$mainMod, Tab, focusmonitor, +1''
        ''$mainMod CTRL, P, exec, ${waybarRestart}/bin/waybarrestart''
        ''$mainMod SHIFT, Tab, focusmonitor, -1''
        ''CTRL ALT, S, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" ~/Pictures/Screenshots/$(date +'%s_grim.png')''
        '', XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_SINK@ 5%-''
        '', XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_SINK@ 5%+''
        '', XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle''
      ];
    };
  };
}
