{ userName, ... }:
let
  ports = [
    53
    67
  ];
in

{
  virtualisation.incus.enable = true;
  virtualisation.incus.socketActivation = true;

  users.users."${userName}".extraGroups = [ "incus" ];

  networking.firewall.interfaces."incusbr*" = {
    allowedTCPPorts = ports;
    allowedUDPPorts = ports;
  };
}
