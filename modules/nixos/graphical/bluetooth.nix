{pkgs, ...}: {
  hardware.bluetooth.powerOnBoot = false;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluez5-experimental;
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
      FastConnectable = true;
    };
  };
}
