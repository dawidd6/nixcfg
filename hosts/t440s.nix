_: {
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.initrd = {
    secrets = {
      "/crypto_keyfile.bin" = null;
    };
    luks.devices = {
      "luks-47d56822-d64c-4b0d-b454-b1cbf08d3b7c".device = "/dev/disk/by-uuid/47d56822-d64c-4b0d-b454-b1cbf08d3b7c";
      "luks-47d56822-d64c-4b0d-b454-b1cbf08d3b7c".keyFile = "/crypto_keyfile.bin";
    };
  };
}
