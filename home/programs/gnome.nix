{
  pkgs,
  lib,
  ...
}: {
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Zafiro-icons-Dark";
      package = pkgs.zafiro-icons;
    };
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };
}
