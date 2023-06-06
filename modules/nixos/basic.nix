{
  inputs,
  lib,
  config,
  pkgs,
  hostname,
  ...
}: {
  # Basic boot
  boot.tmp.cleanOnBoot = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.kernelParams = ["quiet"];

  # Default timezone
  time.timeZone = "Europe/Warsaw";

  # Default locale
  i18n.defaultLocale = "en_GB.UTF-8";

  # Keyboard map
  console.keyMap = "pl2";

  # Networking configuration
  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  # Nix flakes configuration
  nix.registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
  nix.nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
  nix.settings.experimental-features = "nix-command flakes";

  # Nix store optimisation
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 14d";

  # Main user
  users.users.dawidd6 = {
    isNormalUser = true;
    description = "dawidd6";
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    initialPassword = "dawidd6";
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjPWvOxxVyoaF+sZV4Q32mzU5IR+2OKvT+czFwICMNhBq99V88sMH0V+LOs4YwhvameikF502GANoqNVbqiZgfc2uxV4I/9dvTXo3REx+sB9MNasjiUcbz8cdR7zIb1IWBo19VclRSJDE9UFeGJWL72l4OVEvzocbgsDGStjxPo6kILh0f6wXTJr9XRFxZzA0BeQU3D15qIImxKwxQb21aMaPxhRkEgObQweN30LL6rAtenCCJXwpvjsBoJNTE7ZHo8Mlh7lIkXdZxcb7h7jeK3wvkL2BUrwyBbBMf0rk7rAN73Ei3rqF1qDGENNng20j0CRpFaq/cyUcM9b6rTS+7 dawidd6"];
    shell = pkgs.fish;
  };

  # Main shell
  programs.fish.enable = true;

  # Virtualisation stuff
  virtualisation.libvirtd.enable = true;

  # System state version
  # NOT TO BE TOUCHED
  system.stateVersion = "22.11";
}
