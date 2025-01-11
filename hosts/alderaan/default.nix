{
  inputs,
  outputs,
  ...
}:
{
  imports = [
    inputs.hardware.nixosModules.lenovo-thinkpad-t440s
    inputs.hardware.nixosModules.common-pc-ssd

    outputs.nixosModules.basic
    outputs.nixosModules.graphical

    ./configuration.nix
    ./hardware-configuration.nix
  ];

  home = {
    imports = [
      outputs.homeModules.basic
      outputs.homeModules.graphical
    ];
  };
}
