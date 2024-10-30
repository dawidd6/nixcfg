{
  inputs,
  outputs,
  pkgs,
  ...
}:
{
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

  services.logind.lidSwitch = "suspend-then-hibernate";
  systemd.sleep.extraConfig = "HibernateDelaySec=2h";

  boot.binfmt.emulatedSystems = [
    "armv7l-linux"
    "aarch64-linux"
  ];

}
