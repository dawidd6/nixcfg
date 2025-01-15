{
  inputs,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.default
  ];

  disko.memSize = 4096;
}
