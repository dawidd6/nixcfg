{pkgs, ...}: {
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

  # TODO: use home-manager for this?
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  services.openssh.enable = true;
  services.udisks2.enable = true;

  virtualisation.podman.enable = true;

  # TODO: move to separate module
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "06:00";
    flake = "github:dawidd6/nix";
    flags = ["--verbose"];
  };

  networking.hostName = "zotac";

  system.stateVersion = "22.11";
}
