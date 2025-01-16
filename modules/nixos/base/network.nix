{
  lib,
  hostName,
  userName,
  ...
}:
{
  networking.hostName = hostName;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = lib.mkDefault true;

  users.users."${userName}".extraGroups = [ "networkmanager" ];
}
