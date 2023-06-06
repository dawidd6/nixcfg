_: {
  # Machine-specific boot configuration
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
  boot.initrd.luks.devices."luks-8dc1c733-01a8-431b-a8f7-68a51a62504f".device = "/dev/disk/by-uuid/8dc1c733-01a8-431b-a8f7-68a51a62504f";
  boot.initrd.luks.devices."luks-8dc1c733-01a8-431b-a8f7-68a51a62504f".keyFile = "/crypto_keyfile.bin";

  # Patch nixos-hardware service enablement
  # TODO: use my own fork of this repo
  services.throttled.enable = false;
}
