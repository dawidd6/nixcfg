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

  system.stateVersion = "24.11";
}
