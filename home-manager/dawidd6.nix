{ inputs, config, pkgs, ... }: {
  targets.genericLinux.enable = true;

  home.username = "dawidd6";
  home.homeDirectory = "/home/dawidd6";
}
