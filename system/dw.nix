{
  pkgs,
  lib,
  config,
  ...
}: {
  sops.secrets.dw-password.neededForUsers = true;
  users.mutableUsers = false; # required for sops passwords

  users.users.dw = {
    isNormalUser = true;
    ignoreShellProgramCheck = true;
    hashedPasswordFile = config.sops.secrets.dw-password.path;
    description = "school account";
    extraGroups = ["networkmanager"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      google-chrome
      spotify

      obsidian
      vesktop
      rnote
      libreoffice-qt

      kate
      vlc
    ];
  };
}
