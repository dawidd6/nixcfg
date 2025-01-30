{ inputs, ... }:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix

    inputs.self.nixosModules.base
    inputs.self.nixosModules.server
  ];

  swapDevices = [
    {
      device = "/swap";
      size = 8192;
    }
  ];

  system.stateVersion = "24.11";
}
