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
    ./programs/direnv.nix
    ./programs/git.nix
    ./programs/zoxide.nix
    ./programs/bat.nix
    ./programs/ssh.nix
    ./programs/wezterm.nix
    ./programs/hyprland.nix
    ./programs/gh.nix
  ];
  home.username = "kd";
  home.homeDirectory = "/home/kd";
}
