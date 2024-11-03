{
  modulesPath,
  config,
  lib,
  pkgs,
  ...
}:
{
  virtualisation.multipass.enable = true;

  virtualisation.vmVariant = {
    imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

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

    services.sshd.enable = true;
  };

  systemd.tmpfiles.rules =
    let
      firmware = pkgs.runCommandLocal "qemu-firmware" { } ''
        mkdir $out
        cp ${pkgs.qemu}/share/qemu/firmware/*.json $out
        substituteInPlace $out/*.json --replace ${pkgs.qemu} /run/current-system/sw
      '';
    in
    [ "L+ /var/lib/qemu/firmware - - - - ${firmware}" ];
}
