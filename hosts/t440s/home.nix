{ outputs, ... }:
{
  imports = [
    outputs.homeModules.basic
    outputs.homeModules.graphical
  ];
}
