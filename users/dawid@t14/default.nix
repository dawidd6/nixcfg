{ inputs, outputs, ... }: {
  imports = [
    outputs.homeManagerModules.cli
  ];

  home = {
    username = "dawid";
    homeDirectory = "/home/dawid";
    stateVersion = "22.11";
  };
}
