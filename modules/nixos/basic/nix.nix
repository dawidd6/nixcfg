{
  inputs,
  outputs,
  lib,
  config,
  ...
}: {
  nix.registry = lib.mapAttrs (_: value: {flake = value;}) inputs;
  nix.nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 14d";

  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.substituters = ["https://dawidd6.cachix.org"];
  nix.settings.trusted-public-keys = ["dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="];
  nix.settings.trusted-users = ["@wheel" "root"];
  nix.settings.warn-dirty = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    outputs.overlays.additions
    outputs.overlays.modifications
  ];

  systemd.user.services.nix-gc = {
    description = config.systemd.services.nix-gc.description;
    script = config.systemd.services.nix-gc.script;
    startAt = config.systemd.services.nix-gc.startAt;
  };

  systemd.user.timers.nix-gc = {
    timerConfig = config.systemd.timers.nix-gc.timerConfig;
  };
}
