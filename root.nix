{
  pkgs,
  lib,
  inputs,
  hostname,
  ...
}: {
  imports = [
    ./system/hardware-configuration.nix # hardware scan results.
    ./system
    {hostname = hostname;}
    ./users/personal.nix
    ./users/schoolwork.nix
  ];
}
