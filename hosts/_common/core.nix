{
  inputs,
  outputs,
  lib,
  pkgs,
  config,
  hostName,
  userName,
  ...
}:
let
  asGB = size: toString (size * 1024 * 1024 * 1024);
in
{
  # systemd-boot
  boot.tmp.cleanOnBoot = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = lib.mkIf (lib.versionOlder config.system.stateVersion "23.05") "/boot/efi";

  # docs
  documentation.doc.enable = false;
  documentation.info.enable = false;
  documentation.nixos.enable = false;
  documentation.man.generateCaches = false;

  # localization
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "pl";
  services.xserver.xkb.layout = "pl";

  # network-manager
  networking.hostName = hostName;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = lib.mkDefault true;
  networking.nftables.enable = true;

  # user
  users.users."${userName}" = {
    isNormalUser = true;
    description = userName;
    extraGroups = [
      "networkmanager"
      "wheel"
      "lp"
      "incus"
    ];
    initialPassword = userName;
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7iPyyt5SiB7irTbJHMPEJOWhCW+UBhPcNUjZnYAQyB dawidd6@coruscant"
    ];
  };

  # fish
  # TODO: upstream this (disable completions generation)
  environment.etc."fish/generated_completions".text = lib.mkForce "";
  programs.fish.enable = true;
  programs.fish.useBabelfish = true;

  # nix
  nix.channel.enable = false;
  nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
  nix.nixPath = lib.mapAttrsToList (name: _: "${name}=flake:${name}") inputs;
  nix.daemonCPUSchedPolicy = "idle";
  nix.daemonIOSchedClass = "idle";
  nix.settings.min-free = asGB 10;
  nix.settings.max-free = asGB 50;
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.flake-registry = "";
  nix.settings.warn-dirty = false;
  nix.settings.nix-path = config.nix.nixPath;
  nix.settings.substituters = [ "https://dawidd6.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="
  ];
  nix.settings.trusted-users = [
    "@wheel"
    "root"
  ];

  # nixpkgs
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ outputs.overlays.default ];

  # system
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      if [[ -e /run/current-system ]]; then
        ${pkgs.nvd}/bin/nvd --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
      fi
    '';
  };

  # vm
  virtualisation.vmVariant = {
    virtualisation.forwardPorts = [
      {
        from = "host";
        host.port = 22222;
        guest.port = 22;
      }
    ];
    virtualisation.cores = 4;
    virtualisation.memorySize = 4096;
    virtualisation.diskSize = 4096;
    virtualisation.diskImage = null;
    virtualisation.graphics = config.services.xserver.enable;
    virtualisation.qemu.options = lib.mkIf config.services.xserver.enable [
      "-device virtio-vga"
      "-display gtk,grab-on-hover=on"
    ];

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
    services.sshd.enable = true;
  };
}
