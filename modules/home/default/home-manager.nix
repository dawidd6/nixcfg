{
  lib,
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

  home.sessionVariables = {
    __HM_SESS_VARS_SOURCED = "";
  };
}
