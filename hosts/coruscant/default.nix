{
  inputs,
  outputs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
    inputs.disko.nixosModules.default

    outputs.nixosModules.basic
    outputs.nixosModules.graphical

    ./configuration.nix
    ./disko-config.nix
    ./hardware-configuration.nix
  ];

  home = {
    imports = [
      outputs.homeModules.basic
      outputs.homeModules.graphical
    ];
  };
}
