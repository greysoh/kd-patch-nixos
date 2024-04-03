{
  pkgs,
  lib,
  ...
}: {
  sops.secrets.dw-password.neededForUsers = true;
  users.mutableUsers = false; # required for sops passwords

  users.users.dw = {
    isNormalUser = true;
    ignoreShellProgramCheck = true;
    hashedPasswordFile = config.sops.secrets.dw-password.path;
    description = "school account";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kate
      spotify
      vesktop
      obsidian
      rnote
      libreoffice-qt
      vlc
      google-chrome
    ];
  };

  home-manager.users.dw = {
    home.sessionPath = [
      "$HOME/.local/bin"
      "$HOME/bin"
    ];
    home.sessionVariables = {
      TERM = "konsole";
      TERMINAL = "konsole";
      EDITOR = "kate";
    };
    nix.settings.experimental-features = ["nix-command" "flakes"];
    imports = [
      ./programs/zsh.nix
      ./programs/starship.nix
    ];
    home.stateVersion = "23.11";
  };
}
