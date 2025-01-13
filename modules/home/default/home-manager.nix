{
  lib,
  pkgs,
  config,
  userName,
  ...
}@args:
{
  programs.home-manager.enable = true;

  manual.manpages.enable = false;

  news.display = "silent";

  home.stateVersion = lib.mkIf (args ? osConfig) args.osConfig.system.stateVersion;
  home.username = userName;
  home.homeDirectory = "/home/${userName}";

  home.activation.report-changes = config.lib.dag.entryAnywhere ''
    if [[ -v oldGenPath ]]; then
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff $oldGenPath $newGenPath
    fi
  '';

  home.sessionVariables = {
    ELECTRON_TRASH = "gvfs-trash";
    __HM_SESS_VARS_SOURCED = "";
  };
}
