_: {
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  boot.initrd.luks.devices."luks-47d56822-d64c-4b0d-b454-b1cbf08d3b7c".device = "/dev/disk/by-uuid/47d56822-d64c-4b0d-b454-b1cbf08d3b7c";
  boot.initrd.luks.devices."luks-47d56822-d64c-4b0d-b454-b1cbf08d3b7c".keyFile = "/crypto_keyfile.bin";

  # TODO: use home-manager for gpg
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  virtualisation.libvirtd.enable = true;

  networking.hostName = "t440s";

  system.stateVersion = "22.11";
}
