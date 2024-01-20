{
  inputs,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    inputs.hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1

    outputs.nixosModules.basic
    outputs.nixosModules.graphical
  ];

  networking.hostName = "t14";

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  boot.initrd.luks.devices."luks-40a1edfa-0238-4f66-acb9-8ee70a8f03a9".device = "/dev/disk/by-uuid/40a1edfa-0238-4f66-acb9-8ee70a8f03a9";
  boot.initrd.luks.devices."luks-40a1edfa-0238-4f66-acb9-8ee70a8f03a9".keyFile = "/crypto_keyfile.bin";

  system.stateVersion = "23.05";
}
