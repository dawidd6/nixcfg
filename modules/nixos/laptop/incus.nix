{
  userName,
  ...
}:
{
  virtualisation.incus.enable = true;
  virtualisation.incus.socketActivation = true;

  users.users."${userName}".extraGroups = [ "incus" ];

  networking.firewall.interfaces."incusbr*" =
    let
      ports = [
        53
        67
      ];
    in
    {
      allowedTCPPorts = ports;
      allowedUDPPorts = ports;
    };
}
