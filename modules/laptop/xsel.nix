{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.xsel ];

  programs.fish.shellAbbrs = {
    clip = "xsel --clipboard";
  };
}
