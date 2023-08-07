{...}: {
  hardware.bluetooth.powerOnBoot = false;

  virtualisation.libvirtd.enable = true;

  services.fwupd.enable = true;

  documentation.info.enable = false;
  documentation.man.generateCaches = false;
}
