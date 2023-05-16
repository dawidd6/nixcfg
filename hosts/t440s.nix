{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # Set nix package manager options
  nix = {
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # Bootloader stuff, not touched
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Splash boot screen
  boot.initrd.systemd.enable = true;
  boot.kernelParams = ["quiet"];
  boot.plymouth.enable = true;

  # Setup encryption keyfile, not touched
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on LUKS, not touched
  boot.initrd.luks.devices."luks-47d56822-d64c-4b0d-b454-b1cbf08d3b7c".device = "/dev/disk/by-uuid/47d56822-d64c-4b0d-b454-b1cbf08d3b7c";
  boot.initrd.luks.devices."luks-47d56822-d64c-4b0d-b454-b1cbf08d3b7c".keyFile = "/crypto_keyfile.bin";

  # Enable networking and set hostname
  networking.hostName = "t440s";
  networking.networkmanager.enable = true;

  # Set your time zone
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define my user account
  users.users.dawidd6 = {
    isNormalUser = true;
    description = "dawidd6";
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    initialPassword = "dawidd6";
    shell = pkgs.fish;
  };

  # Enable automatic login for the user
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "dawidd6";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Enable relevant programs
  programs.dconf.enable = true;
  programs.fish.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable tlp and disable conflicting service
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;

  # Enable libvirtd for virt-manager
  virtualisation.libvirtd.enable = true;

  # DO NOT CHANGE
  system.stateVersion = "22.11";
}
