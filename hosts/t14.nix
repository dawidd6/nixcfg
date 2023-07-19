_: {
  # Machine-specific boot configuration
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-40a1edfa-0238-4f66-acb9-8ee70a8f03a9".device = "/dev/disk/by-uuid/40a1edfa-0238-4f66-acb9-8ee70a8f03a9";
  boot.initrd.luks.devices."luks-40a1edfa-0238-4f66-acb9-8ee70a8f03a9".keyFile = "/crypto_keyfile.bin";
}
