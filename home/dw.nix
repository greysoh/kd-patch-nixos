{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./core.nix
    ./programs/zsh.nix
    ./programs/starship.nix
  ];
  home.username = "dw";
  home.homeDirectory = "/home/dw";
}
