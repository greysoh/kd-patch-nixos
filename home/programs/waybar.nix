{
  pkgs,
  lib,
  ...
}: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        modules-left = ["clock" "hyprland/window"];
        modules-center = ["hyprland/workspaces"];
        modules-right = ["tray" "memory" "cpu" "pulseaudio" "battery"];
        memory.format = " {total}%";
        cpu.format = " {usage}%";
        battery = {
          format = "{capacity}% {icon}";
          format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          format-charging = "{capacity}% {icon}󱐋";
        };
        pulseaudio = {
          format = "{format_source} {volume}% {icon}";
          format-bluetooth = "{volume}% {icon}";
          format-muted = "";
          format-icons = {
            default = ["" ""];
          };
          format-source = "";
          format-source-muted = "";
          scroll-step = 1;
        };
      };
    };
    style = ./waybar_style.css;
  };
}
