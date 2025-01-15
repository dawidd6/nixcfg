{ outputs, userName, ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix

    outputs.nixosModules.basic
  ];

  home-manager.users.${userName} = ./home.nix;

  services.openssh.enable = true;

  # TODO: check if we can connect as non root
  #users.users.root.openssh.authorizedKeys.keys = [
  #  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7iPyyt5SiB7irTbJHMPEJOWhCW+UBhPcNUjZnYAQyB dawidd6@coruscant"
  #];

  swapDevices = [
    {
      device = "/swap";
      size = 8192;
    }
  ];

  system.stateVersion = "24.11";
}
