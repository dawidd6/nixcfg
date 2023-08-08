{
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    outputs.nixosModules.basic
  ];

  networking.hostName = "zotac";
  networking.networkmanager.wifi.powersave = false;

  fileSystems."/home/dawidd6/Backups" = {
    device = "/dev/disk/by-label/Backups";
    fsType = "ext4";
    options = ["nofail"];
  };

  environment.systemPackages = with pkgs; [
    borgbackup
    file
    git
    htop
    lm_sensors
    tmux
  ];

  services.openssh.enable = true;
  services.udisks2.enable = true;

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "06:00";
    flake = "github:dawidd6/nix";
    flags = ["--verbose"];
  };

  system.stateVersion = "22.11";
}
