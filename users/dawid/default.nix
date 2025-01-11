{ outputs, ... }:
{
  imports = [
    outputs.homeModules.basic

    ./home.nix
  ];
}
