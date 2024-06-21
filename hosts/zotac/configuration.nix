{ outputs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    outputs.nixosModules.basic
  ];

  networking.hostName = "zotac";
  networking.networkmanager.wifi.powersave = false;

  services.openssh.enable = true;
  services.udisks2.enable = true;

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "06:00";
    flake = "github:dawidd6/nixcfg";
    flags = [ "--verbose" ];
  };

  system.stateVersion = "22.11";
}
