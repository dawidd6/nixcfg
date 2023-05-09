{ lib, config, pkgs, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "x86_64-linux";

  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/mmcblk0p2";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/mmcblk0p1";
      fsType = "vfat";
    };
    "/home/dawidd6/Backups" = {
      device = "/dev/disk/by-label/Backups";
      fsType = "ext4";
      options = [ "nofail" ];
    };
  };

  boot = {
    initrd.availableKernelModules = [ "ahci" "xhci_pci" "usbhid" "ums_realtek" "usb_storage" "sd_mod" "sdhci_pci" ];
    cleanTmpDir = true;
    kernelModules = [ "kvm-intel" ];
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  networking = {
    hostName = "zotac";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_GB.UTF-8";

  users = {
    defaultUserShell = pkgs.fish;
    users = {
      dawidd6 = {
        description = "dawidd6";
        initialPassword = "dawidd6";
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
        openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjPWvOxxVyoaF+sZV4Q32mzU5IR+2OKvT+czFwICMNhBq99V88sMH0V+LOs4YwhvameikF502GANoqNVbqiZgfc2uxV4I/9dvTXo3REx+sB9MNasjiUcbz8cdR7zIb1IWBo19VclRSJDE9UFeGJWL72l4OVEvzocbgsDGStjxPo6kILh0f6wXTJr9XRFxZzA0BeQU3D15qIImxKwxQb21aMaPxhRkEgObQweN30LL6rAtenCCJXwpvjsBoJNTE7ZHo8Mlh7lIkXdZxcb7h7jeK3wvkL2BUrwyBbBMf0rk7rAN73Ei3rqF1qDGENNng20j0CRpFaq/cyUcM9b6rTS+7 dawidd6" ];
      };
    };
  };

  environment.systemPackages = [
    pkgs.borgbackup
    pkgs.file
    pkgs.htop
    pkgs.lm_sensors
    pkgs.tmux
  ];

  programs = {
    git.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    fish = {
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
  };

  services = {
    openssh.enable = true;
    udisks2.enable = true;
  };

  virtualisation.podman.enable = true;

  system = {
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      dates = "06:00";
      flake = "github:dawidd6/nixos";
    };
    stateVersion = "22.11";
  };
}
