{
  outputs,
  ...
}: {
  imports = [
    outputs.homeModules.basic
  ];

  nixpkgs.overlays = [
    outputs.overlays.additions
    outputs.overlays.modifications
  ];

  home.stateVersion = "22.11";
  home.username = "dawid";
}
