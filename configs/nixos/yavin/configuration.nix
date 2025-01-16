{
  inputs,
  outputs,
  userName,
  ...
}:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix

    inputs.hardware.nixosModules.common-cpu-intel

    outputs.nixosModules.server
  ];

  home-manager.users.${userName} = ./home.nix;

  swapDevices = [
    {
      device = "/swap";
      size = 4096;
    }
  ];

  system.stateVersion = "24.11";
}
