{
  inputs,
  outputs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    inputs.hardware.nixosModules.lenovo-thinkpad-t440s
    inputs.hardware.nixosModules.common-pc-ssd

    outputs.nixosModules.basic
    outputs.nixosModules.graphical
  ];

  home = {
    imports = [
      outputs.homeModules.basic
      outputs.homeModules.graphical
    ];
  };

  networking.networkmanager.wifi.powersave = false;

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };
  boot.initrd.luks.devices."luks-4af00ef3-9f52-4447-9f2b-fcffedb33cde".device = "/dev/disk/by-uuid/4af00ef3-9f52-4447-9f2b-fcffedb33cde";
  boot.initrd.luks.devices."luks-47d56822-d64c-4b0d-b454-b1cbf08d3b7c".device = "/dev/disk/by-uuid/47d56822-d64c-4b0d-b454-b1cbf08d3b7c";
  boot.initrd.luks.devices."luks-47d56822-d64c-4b0d-b454-b1cbf08d3b7c".keyFile = "/crypto_keyfile.bin";
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ehci_pci"
    "ahci"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/bf59a5a8-90a0-490b-a79e-1ca25aec0554";
    fsType = "ext4";
  };
  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/B687-B714";
    fsType = "vfat";
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/47a4ad5d-bc4c-43a4-9bb8-e59d6ecb407c"; } ];

  system.stateVersion = "22.11";
}
