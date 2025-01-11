{
  inputs,
  outputs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel

    outputs.nixosModules.basic

    ./configuration.nix
    ./hardware-configuration.nix
  ];

  home = {
    imports = [ outputs.homeModules.basic ];
  };
}
