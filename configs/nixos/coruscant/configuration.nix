{
  inputs,
  ...
}:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix

    inputs.hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1

    inputs.self.nixosModules.base
    inputs.self.nixosModules.laptop
  ];

  swapDevices = [
    {
      device = "/swap";
      size = 20480;
    }
  ];

  system.stateVersion = "23.11";
}
