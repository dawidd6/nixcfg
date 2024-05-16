_: {
  programs.gpg.enable = true;
  programs.gpg.scdaemonSettings = {
    disable-ccid = true;
  };
  services.gpg-agent.enable = true;
  services.gpg-agent.enableSshSupport = false;
  services.gpg-agent.pinentryFlavor = "gnome3";
}
