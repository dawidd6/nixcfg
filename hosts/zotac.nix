{pkgs, ...}: {
  # Machine-specific boot configuration
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # External disk automount
  fileSystems."/home/dawidd6/Backups" = {
    device = "/dev/disk/by-label/Backups";
    fsType = "ext4";
    options = ["nofail"];
  };

  # Special packages for this host
  environment.systemPackages = with pkgs; [
    borgbackup
    file
    git
    htop
    lm_sensors
    tmux
  ];

  # Special services for this host
  services.openssh.enable = true;
  services.udisks2.enable = true;

  # Auto-upgrade for this host
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "06:00";
    flake = "github:dawidd6/nix";
    flags = ["--verbose"];
  };
}
