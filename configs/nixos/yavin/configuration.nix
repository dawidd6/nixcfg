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

    outputs.nixosModules.basic
  ];

  home-manager.users.${userName} = ./home.nix;

  services.openssh.enable = true;
  services.udisks2.enable = true;

  swapDevices = [
    {
      device = "/swap";
      size = 4096;
    }
  ];

  system.stateVersion = "24.11";
}
