{...}: {
  boot.kernelParams = ["quiet"];
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
}
