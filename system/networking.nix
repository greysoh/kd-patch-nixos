{
  pkgs,
  lib,
  ...
}: {
  networking.extraHosts = ''
    10.0.0.129 nmcs
    10.0.0.12 mcs
    192.168.0.120 idrac
    192.168.0.171 proxmox
    192.168.0.41 dockerzero
    192.168.0.40 pihole
  '';
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.networkmanager.enable = true;
}
