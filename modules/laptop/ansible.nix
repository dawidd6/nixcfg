{
  mkModule,
  pkgs,
  ...
}:
let
  packages = with pkgs; [
    ansible
    ansible-lint
  ];
in
mkModule {
  onNixos = {
    environment.systemPackages = packages;
  };

  onHome = {
    home.packages = packages;
  };
}
