{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./networking.nix
    ./nvidia.nix
    ./xserver.nix
    ./sound.nix
    ./i18n.nix
    ./desktop/plasma.nix
    ./sops.nix
  ];
  networking.hostName = "zero";
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
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
  environment.systemPackages = with pkgs; [
    vim
  ];
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = lib.mkForce pkgs.pinentry-qt;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    # if ur cursor becomes invisble
    WLR_NO_HARDWARE_CURSORS = "1";
    # tell electron to use wayland
    NIXOS_OZONE_WL = "1";
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  fonts.packages = with pkgs; [
    liberation_ttf
    google-fonts
    nerdfonts
  ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
}
