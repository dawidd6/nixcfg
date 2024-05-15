_: {
  services.pcscd.enable = true;

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = true;

  hardware.gpgSmartcards.enable = true;
}
