{
  pkgs,
  config,
  username,
  ...
}:
{
  programs.home-manager.enable = true;

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.activation.report-changes = config.lib.dag.entryAnywhere ''
    if [[ -v oldGenPath ]]; then
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff $oldGenPath $newGenPath
    fi
  '';

  news.display = "silent";
}
