{...}: {
  programs.command-not-found.enable = false;

  hardware.bluetooth.powerOnBoot = false;

  virtualisation.libvirtd.enable = true;

  services.fwupd.enable = true;
}
