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

    inputs.hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1

    outputs.nixosModules.laptop
  ];

  home-manager.users.${userName} = ./home.nix;

  swapDevices = [
    {
      device = "/swap";
      size = 20480;
    }
  ];

  system.stateVersion = "23.11";
}
