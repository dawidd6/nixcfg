{
  lib,
  config,
  ...
}: {
  programs.home-manager.enable = true;

  home.username = lib.mkDefault "dawidd6";
  home.homeDirectory = "/home/${config.home.username}";

  news.display = "silent";
}
