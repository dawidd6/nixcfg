{
  lib,
  pkgs,
  config,
  ...
}: {
  programs.home-manager.enable = true;

  home.username = lib.mkDefault "dawidd6";
  home.homeDirectory = "/home/${config.home.username}";

  home.activation.report-changes = config.lib.dag.entryAnywhere ''
    ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff $oldGenPath $newGenPath
  '';

  news.display = "silent";
}
