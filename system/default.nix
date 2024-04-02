{ pkgs, lib, ... }:
{
  imports = [
    ./networking.nix
    ./nvidia.nix
    ./xserver.nix
    ./sound.nix
    ./i18n.nix
    ./desktop/plasma.nix
  ];
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # ssh
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
  };
  nixpkgs.config.allowUnfree = true;
}
