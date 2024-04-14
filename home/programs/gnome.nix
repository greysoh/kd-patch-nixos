{
  pkgs,
  lib,
  ...
}: {
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

    cursorTheme = {
      name = "Graphite-dark";
      package = pkgs.graphite-cursors;
    };
  };

  dconf = {
    enable = true;

    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;

        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "unite@hardpixel.eu"
        ];
      };

      "org/gnome/shell/extensions/user-theme" = {
        name = "Materia-dark";
      };

      "org/gnome/shell/extensions/unite" = {
        desktop-name-text = "Desktop";
        greyscale-tray-icons = true;
        hide-activities-button = "always";
        hide-window-titlebars = "always";
        show-window-buttons = "always";
        show-window-title = "tiled";
        window-buttons-placement = "first";
        window-buttons-theme = "arc";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file:///${./wallpaper.jpg}";
        picture-uri-dark = "file:///${./wallpaper.jpg}";
      };
    };
  };

  home.packages = with pkgs; [
    # Gnome extensions
    gnomeExtensions.unite
    gnomeExtensions.user-themes

    # Theme
    materia-theme
  ];
}
