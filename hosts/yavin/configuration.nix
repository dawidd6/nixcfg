_: {
  networking.networkmanager.wifi.powersave = false;

  services.openssh.enable = true;
  services.udisks2.enable = true;

  security.sudo.wheelNeedsPassword = false;

  swapDevices = [
    {
      device = "/swap";
      size = 4096;
    }
  ];

  system.stateVersion = "22.11";
}
