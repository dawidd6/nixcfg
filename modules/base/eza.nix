{
  pkgs,
  mkModule,
  ...
}:
mkModule {
  onNixos = {
    environment.systemPackages = [ pkgs.eza ];
  };

  onHome = {
    home.packages = [ pkgs.eza ];
  };

  onAny = {
    programs.fish.shellAliases = {
      eza = "eza --group-directories-first --group --header --time-style=long-iso";
      la = "eza -a";
      ll = "eza -l";
      lla = "eza -la";
      ls = "eza";
      lt = "eza --tree";
    };
  };
}
