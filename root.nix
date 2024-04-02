{ pkgs, lib, inputs, ... }:

{
  imports = [
    ./system/hardware-configuration.nix # hardware scan results.
    ./system
    ./users/personal.nix
    ./users/schoolwork.nix
  ];
}
