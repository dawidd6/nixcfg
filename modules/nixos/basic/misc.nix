{...}: {
  hardware.bluetooth.powerOnBoot = false;

  virtualisation.libvirtd.enable = true;

  services.fwupd.enable = true;

  documentation.man.generateCaches = false;
}
