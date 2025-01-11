{
  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7iPyyt5SiB7irTbJHMPEJOWhCW+UBhPcNUjZnYAQyB dawidd6@coruscant"
  ];

  swapDevices = [
    {
      device = "/swap";
      size = 8192;
    }
  ];

  system.stateVersion = "24.11";
}
