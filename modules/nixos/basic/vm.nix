{
  lib,
  config,
  ...
}:
{
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
