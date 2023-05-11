{ inputs, config, pkgs, ... }: {
  targets.genericLinux.enable = true;

  home.username = "dawid";
  home.homeDirectory = "/home/dawid";
}
