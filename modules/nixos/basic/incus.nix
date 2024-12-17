_: {
  virtualisation.incus.enable = true;
  virtualisation.incus.socketActivation = true;

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
