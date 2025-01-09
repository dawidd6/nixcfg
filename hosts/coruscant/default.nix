{
  inputs,
  outputs,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    inputs.hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1

    inputs.disko.nixosModules.default

    outputs.nixosModules.basic
    outputs.nixosModules.graphical
  ];

  home = {
    imports = [
      outputs.homeModules.basic
      outputs.homeModules.graphical
    ];
  };

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  services.logind.lidSwitch = "suspend-then-hibernate";
  systemd.sleep.extraConfig = "HibernateDelaySec=2h";

  boot.binfmt.emulatedSystems = [
    "armv7l-linux"
    "aarch64-linux"
  ];

  swapDevices = [
    {
      device = "/swap";
      size = 20480;
    }
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "ehci_pci"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
  ];
  boot.kernelModules = [ "kvm-amd" ];

  disko = {
    memSize = 4096;
    devices = {
      disk = {
        main = {
          imageSize = "64G";
          type = "disk";
          device = "/dev/nvme0n1";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                size = "500M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "cryptroot";
                  content = {
                    type = "filesystem";
                    format = "ext4";
                    mountpoint = "/";
                  };
                };
              };
            };
          };
        };
      };
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "23.11";
}
