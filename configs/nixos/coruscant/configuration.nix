{
  inputs,
  outputs,
  pkgs,
  userName,
  ...
}:
{
  imports = [
    ./disko-config.nix
    ./hardware-configuration.nix

    inputs.hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1

    outputs.nixosModules.laptop
  ];

  home-manager.users.${userName} = ./home.nix;

  boot.kernelParams = [ "acpi.ec_no_wakeup=1" ];

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  #services.logind.lidSwitch = "hibernate";

  boot.binfmt.emulatedSystems = [
    "armv7l-linux"
    "aarch64-linux"
  ];

  swapDevices = [
    {
      device = "/swap";
      size = 20480;
    }
  ];

  system.stateVersion = "23.11";
}
