{
  pkgs,
  config,
  lib,
  userName,
  ...
}@args:
{
  programs.home-manager.enable = true;

  home.stateVersion = lib.mkIf (args ? osConfig) args.osConfig.system.stateVersion;
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  home.activation.report-changes = config.lib.dag.entryAnywhere ''
    if [[ -v oldGenPath ]]; then
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff $oldGenPath $newGenPath
    fi
  '';

  news.display = "silent";

  manual.manpages.enable = false;
}
