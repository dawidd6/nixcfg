{modulesPath, config, lib, ...}: {
  virtualisation.vmVariant = {
    imports = [(modulesPath + "/profiles/qemu-guest.nix")];

    # Avoid VM build failure when disk encryption is enabled for a host
    boot.initrd.secrets = lib.mkForce {};

    virtualisation.forwardPorts = [
      {
        from = "host";
        host.port = 22222;
        guest.port = 22;
      }
    ];
    virtualisation.cores = 4;
    virtualisation.memorySize = 4096;
    virtualisation.graphics = config.services.xserver.enable;
    virtualisation.qemu.options = lib.mkIf config.services.xserver.enable [
      "-device virtio-vga"
      "-display gtk,grab-on-hover=on"
    ];

    services.sshd.enable = true;
  };
}
