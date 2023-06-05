_: {
  boot.plymouth.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing.enable = true;
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      layout = "pl";
      xkbVariant = "";
    };
    thermald.enable = true;
    upower.enable = true;
    fwupd.enable = true;
  };

  sound.enable = true;

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  powerManagement.powertop.enable = true;
}
