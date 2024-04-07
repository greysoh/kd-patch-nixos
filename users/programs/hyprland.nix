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
in {
  wayland.windowManager.hyprland = {
    # allow home-manager to configure hyprland
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;

    settings = {
      exec-once = ''${startupScript}/bin/start'';
      general.layout = "master";
    };
  };
}
