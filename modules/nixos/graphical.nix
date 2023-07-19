_: {
  # Flicker-free boot
  boot.plymouth.enable = true;

  # Bluetooth configuration
  hardware.bluetooth.powerOnBoot = false;

  # Sound configuration
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  sound.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;

  # Printing services
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;

  # Desktop environment
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.layout = "pl";
  services.xserver.xkbVariant = "";

  # Power management
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;
  services.upower.enable = true;

  # Firmware management
  services.fwupd.enable = true;
}
