{
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.default

    inputs.hardware.nixosModules.lenovo-thinkpad-t440s
    inputs.hardware.nixosModules.common-pc-ssd

    outputs.nixosModules.basic
    outputs.nixosModules.graphical
  ];

  networking.networkmanager.wifi.powersave = false;

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  boot.initrd.luks.devices."luks-47d56822-d64c-4b0d-b454-b1cbf08d3b7c".device = "/dev/disk/by-uuid/47d56822-d64c-4b0d-b454-b1cbf08d3b7c";
  boot.initrd.luks.devices."luks-47d56822-d64c-4b0d-b454-b1cbf08d3b7c".keyFile = "/crypto_keyfile.bin";

  system.stateVersion = "22.11";
}
