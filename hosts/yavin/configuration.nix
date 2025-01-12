{ pkgs, ... }:
{
  services.openssh.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    htop
    lm_sensors
  ];

  security.sudo.wheelNeedsPassword = false;

  swapDevices = [
    {
      device = "/swap";
      size = 4096;
    }
  ];

  system.stateVersion = "22.11";
}
