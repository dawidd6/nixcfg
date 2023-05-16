{ inputs, outputs, ... }: {
  imports = [
    outputs.homeManagerModules.cli
    outputs.homeManagerModules.gui
  ];

  home = {
    username = "dawidd6";
    homeDirectory = "/home/dawidd6";
    stateVersion = "22.11";
  };
}
