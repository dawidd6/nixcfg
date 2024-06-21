{ lib, ... }:
{
  networking.hostName = lib.mkDefault null;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = lib.mkDefault true;
}
