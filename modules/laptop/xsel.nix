{ pkgs, mkModule, ... }:
mkModule {
  onNixos = {
    environment.systemPackages = [ pkgs.xsel ];
  };

  onHome = {
    home.packages = [ pkgs.xsel ];
  };

  onAny = {
    programs.fish.shellAbbrs = {
      clip = "xsel --clipboard";
    };
  };
}
