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

  networking.useNetworkd = true;

  networking.nftables.enable = true;

  users.users."${userName}".extraGroups = [ "networkmanager" ];
}
