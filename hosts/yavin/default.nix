{
  inputs,
  outputs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    inputs.hardware.nixosModules.common-cpu-intel

    outputs.nixosModules.basic
  ];

  home = {
    imports = [ outputs.homeModules.basic ];
  };

  networking.networkmanager.wifi.powersave = false;

  services.openssh.enable = true;
  services.udisks2.enable = true;

  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "ums_realtek"
    "uas"
    "sd_mod"
    "sdhci_pci"
  ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/76fee5e5-78de-4203-af82-0dc3be4ad74b";
    fsType = "ext4";
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/404E-91CE";
    fsType = "vfat";
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "22.11";
}
