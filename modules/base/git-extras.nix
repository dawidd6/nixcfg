{ pkgs, mkModule, ... }:
mkModule {
  onNixos = {
    environment.systemPackages = [ pkgs.git-extras ];
  };

  onHome = {
    home.packages = [ pkgs.git-extras ];
  };
}
