{ outputs, userName, ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix

    outputs.nixosModules.server
  ];

  home-manager.users.${userName} = ./home.nix;

  swapDevices = [
    {
      device = "/swap";
      size = 8192;
    }
  ];

  system.stateVersion = "24.11";
}
