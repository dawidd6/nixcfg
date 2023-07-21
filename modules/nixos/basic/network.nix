{
  hostname,
  lib,
  ...
}: {
  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = lib.mkDefault true;
}
