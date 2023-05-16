{ inputs, lib, config, pkgs, ... }: {
  # Drive
  fileSystems."/home/dawidd6/Backups" = {
    device = "/dev/disk/by-label/Backups";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  # Bootloader
  boot.cleanTmpDir = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Nixpkgs
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  # Nix
  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
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

  # Network
  networking.hostName = "zotac";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  # Locale
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "pl2";

  # Users
  users.users.dawidd6 = {
    description = "dawidd6";
    initialPassword = "dawidd6";
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjPWvOxxVyoaF+sZV4Q32mzU5IR+2OKvT+czFwICMNhBq99V88sMH0V+LOs4YwhvameikF502GANoqNVbqiZgfc2uxV4I/9dvTXo3REx+sB9MNasjiUcbz8cdR7zIb1IWBo19VclRSJDE9UFeGJWL72l4OVEvzocbgsDGStjxPo6kILh0f6wXTJr9XRFxZzA0BeQU3D15qIImxKwxQb21aMaPxhRkEgObQweN30LL6rAtenCCJXwpvjsBoJNTE7ZHo8Mlh7lIkXdZxcb7h7jeK3wvkL2BUrwyBbBMf0rk7rAN73Ei3rqF1qDGENNng20j0CRpFaq/cyUcM9b6rTS+7 dawidd6" ];
    shell = pkgs.fish;
  };

  # Packages
  environment.systemPackages = with pkgs; [
    borgbackup
    file
    htop
    lm_sensors
    tmux
  ];

  # Programs
  programs.git.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_color_command green
      set fish_color_param normal
      set fish_color_error red --bold
      set fish_color_normal normal
      set fish_color_comment brblack
      set fish_color_quote yellow
    '';
  };

  # Services
  services.openssh.enable = true;
  services.udisks2.enable = true;

  # Virtualisation
  virtualisation.podman.enable = true;

  # System
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "06:00";
    flake = "github:dawidd6/nix";
    flags = [ "--verbose" ];
  };
  system.stateVersion = "22.11";
}
