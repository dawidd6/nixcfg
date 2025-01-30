{
  userName,
  mkModule,
  ...
}:
mkModule {
  onHome = {
    programs.home-manager.enable = true;

    manual.manpages.enable = false;

    news.display = "silent";

    home.username = userName;
    home.homeDirectory = "/home/${userName}";

    # Always export session variables (even on relogin)
    home.sessionVariables.__HM_SESS_VARS_SOURCED = "";
  };
}
