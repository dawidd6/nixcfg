{
  inputs,
  outputs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")

    inputs.disko.nixosModules.default

    outputs.nixosModules.basic

    ./configuration.nix
    ./disko-config.nix
    ./hardware-configuration.nix
  ];
}
