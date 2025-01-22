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

  networking.nftables.enable = true;

  services.resolved.enable = true;

  users.users."${userName}".extraGroups = [ "networkmanager" ];
}
