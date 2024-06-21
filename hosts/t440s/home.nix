{ outputs, ... }:
{
  imports = [
    outputs.homeModules.basic
    outputs.homeModules.graphical
  ];

  home.stateVersion = "22.11";
}
