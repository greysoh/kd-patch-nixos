{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  sops.secrets.kd-password.neededForUsers = true;
  users.mutableUsers = false; # required for sops passwords

  users.users.kd = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.kd-password.path;
    ignoreShellProgramCheck = true;
    description = "zero";
    extraGroups = ["networkmanager" "wheel"] ++ ifTheyExist ["docker" "git" "mysql" "network"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      (builtins.readFile ./id_zero.pub)
    ];
    packages = with pkgs; [
      tor-browser
      floorp
      vesktop
      spotify

      # code
      kate
      vscode
      gh
      lazygit
      nixpkgs-fmt

      # Notes
      rnote
      obsidian
      libreoffice-qt

      # Terminal
      alejandra
      libnotify
      eza
      bat
      bottom
      fzf

      # Idek
      vlc

      thunderbird
      adoptopenjdk-icedtea-web
      openjfx17
    ];
  };
}
