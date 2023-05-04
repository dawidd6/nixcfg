{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usbhid" "ums_realtek" "usb_storage" "sd_mod" "sdhci_pci" ];
  boot.kernelModules = [ "kvm-intel" ];

  fileSystems."/".device = "/dev/mmcblk0p2";
  fileSystems."/".fsType = "ext4";
  fileSystems."/boot/efi".device = "/dev/mmcblk0p1";
  fileSystems."/boot/efi".fsType = "vfat";
  fileSystems."/home/dawidd6/Backups".device = "/dev/disk/by-label/Backups";
  fileSystems."/home/dawidd6/Backups".fsType = "ext4";
  fileSystems."/home/dawidd6/Backups".options = [ "nofail" ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
