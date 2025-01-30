{
  mkModule,
  pkgs,
  ...
}:
mkModule {
  onNixos = {
    environment.systemPackages = [ pkgs.trash-cli ];
  };

  onHome = {
    home.packages = [ pkgs.trash-cli ];
  };

  onAny = {
    programs.fish.shellAbbrs.rm = "trash";
  };
}
