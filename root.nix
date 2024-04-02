{ pkgs, lib, inputs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix # hardware scan results.
    ./system
    ./users/personal.nix
    ./users/schoolwork.nix
  ];
}
