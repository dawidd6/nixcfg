{
  pkgs,
  ...
}:

{

  environment.systemPackages = [ pkgs.eza ];

  programs.fish.shellAliases = {
    eza = "eza --group-directories-first --group --header --time-style=long-iso";
    la = "eza -a";
    ll = "eza -l";
    lla = "eza -la";
    ls = "eza";
    lt = "eza --tree";
  };
}
