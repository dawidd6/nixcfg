{outputs, ...}: {
  imports = [
    outputs.homeModules.basic
    outputs.homeModules.graphical
  ];

  home.stateVersion = "23.05";
}
