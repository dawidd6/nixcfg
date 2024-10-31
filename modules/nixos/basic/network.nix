{ lib, hostName, ... }:
{
  networking.hostName = hostName;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = lib.mkDefault true;
}
