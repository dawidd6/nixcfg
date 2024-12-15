_: {
  virtualisation.incus.enable = true;
  virtualisation.incus.socketActivation = true;

  networking.firewall.trustedInterfaces = [
    "incusbr0"
    "incusbr-1000"
  ];
}
