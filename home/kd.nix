# stub configuration, broken.
{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
    ./core.nix
    ./sops.nix
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/git.nix
    ./programs/bat.nix
    ./programs/ssh.nix
    ./programs/kitty.nix
    ./programs/gh.nix
    ./programs/gnome.nix
    ./programs/hyprland.nix
  ];
  home.username = "kd";
  home.homeDirectory = "/home/kd";
}
