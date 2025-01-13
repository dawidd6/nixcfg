{
  pkgs,
  ...
}:
{
  programs.gpg.enable = true;
  programs.gpg.scdaemonSettings = {
    disable-ccid = true;
  };
  services.gpg-agent.enable = true;
  services.gpg-agent.enableSshSupport = false;
  services.gpg-agent.pinentryPackage = pkgs.pinentry-gnome3;
}
