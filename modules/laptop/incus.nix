{ mkModule, userName, ... }:
let
  ports = [
    53
    67
  ];
in
mkModule {
  onNixos = {
    virtualisation.incus.enable = true;
    virtualisation.incus.socketActivation = true;

    users.users."${userName}".extraGroups = [ "incus" ];

    networking.firewall.interfaces."incusbr*" = {
      allowedTCPPorts = ports;
      allowedUDPPorts = ports;
    };
  };
}
