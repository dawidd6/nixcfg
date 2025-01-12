{ pkgs, ... }:
{
  services.openssh.enable = true;

  # TODO: check if we can connect as non root
  #users.users.root.openssh.authorizedKeys.keys = [
  #  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7iPyyt5SiB7irTbJHMPEJOWhCW+UBhPcNUjZnYAQyB dawidd6@coruscant"
  #];

  environment.systemPackages = with pkgs; [
    htop
  ];

  security.sudo.wheelNeedsPassword = false;

  swapDevices = [
    {
      device = "/swap";
      size = 8192;
    }
  ];

  system.stateVersion = "24.11";
}
