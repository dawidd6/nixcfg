{ inputs, lib, config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  nix = {
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    cleanTmpDir = true;
  };
  networking = {
    hostName = "zotac";
    networkmanager = {
      enable = true;
      wifi = {
        powersave = false;
      };
    };
  };
  time = {
    timeZone = "Europe/Warsaw";
  };
  i18n = {
    defaultLocale = "en_GB.UTF-8";
  };
  users = {
    users = {
      dawidd6 = {
        isNormalUser = true;
        description = "dawidd6";
        extraGroups = [
	  "networkmanager"
	  "wheel"
	];
        initialPassword = "dawidd6";
	openssh = {
	  authorizedKeys = {
	    keys = [
	      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjPWvOxxVyoaF+sZV4Q32mzU5IR+2OKvT+czFwICMNhBq99V88sMH0V+LOs4YwhvameikF502GANoqNVbqiZgfc2uxV4I/9dvTXo3REx+sB9MNasjiUcbz8cdR7zIb1IWBo19VclRSJDE9UFeGJWL72l4OVEvzocbgsDGStjxPo6kILh0f6wXTJr9XRFxZzA0BeQU3D15qIImxKwxQb21aMaPxhRkEgObQweN30LL6rAtenCCJXwpvjsBoJNTE7ZHo8Mlh7lIkXdZxcb7h7jeK3wvkL2BUrwyBbBMf0rk7rAN73Ei3rqF1qDGENNng20j0CRpFaq/cyUcM9b6rTS+7 dawidd6"
	    ];
	  };
	};
      };
    };
  };
  environment = {
    systemPackages = with pkgs; [
      htop
      lm_sensors
    ];
  };
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    git = {
      enable = true;
    };
  };
  services = {
    openssh = {
      enable = true;
    };
  };
  virtualisation = {
    podman = {
      enable = true;
    };
  };
  system = {
    stateVersion = "22.11";
  };
}
