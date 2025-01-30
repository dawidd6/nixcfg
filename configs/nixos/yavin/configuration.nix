{
  inputs,
  ...
}:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix

    inputs.hardware.nixosModules.common-cpu-intel

    inputs.self.nixosModules.base
    inputs.self.nixosModules.server
  ];

  system.stateVersion = "24.11";
}
