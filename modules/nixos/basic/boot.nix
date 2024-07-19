{ lib, config, ... }:
{
  boot.tmp.cleanOnBoot = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = lib.mkIf (lib.versionOlder config.system.stateVersion "23.05") "/boot/efi";
}
