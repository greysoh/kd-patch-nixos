{
  pkgs,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    font = {
      package = pkgs.jetbrains-mono;
      name = "JetBrains Mono";
    };

    environment = {
      EDITOR = "code --wait";
      TERM = "xterm-256color";
    };

    settings = {
      window_padding_width = "4";
      shell = "${pkgs.zsh}/bin/zsh";

      background = "#0c0e0f";
      foreground = "#edeff0";
      cursor = "#edeff0";
      cursor_shape = "beam";

      selection_background = "#1f2122";

      color0 = "#232526";
      color8 = "#0c0e0f";
      color1 = "#df5b61";
      color9 = "#e8646a";
      color2 = "#78b892";
      color10 = "#81c19b";
      color3 = "#de8f78";
      color11 = "#e79881";
      color4 = "#6791c9";
      color12 = "#709ad2";
      color5 = "#bc83e3";
      color13 = "#c58cec";
      color6 = "#67afc1";
      color14 = "#70b8ca";
      color7 = "#e4e6e7";
      color15 = "#f2f4f5";
    };
  };
}
