{
  outputs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/virtualisation/qemu-vm.nix")
    (modulesPath + "/profiles/qemu-guest.nix")

    outputs.nixosModules.basic
    outputs.nixosModules.graphical
  ];

  virtualisation.forwardPorts = [
    {
      from = "host";
      host.port = 22222;
      guest.port = 22;
    }
  ];
  virtualisation.cores = 4;
  virtualisation.memorySize = 4096;
  virtualisation.graphics = true;
  virtualisation.qemu.options = [
    "-device virtio-vga-gl"
    "-display gtk,gl=on,grab-on-hover=on"
  ];

  services.sshd.enable = true;

  networking.hostName = "vm";

  #services.spice-vdagentd.enable = true;
  #services.qemuGuest.enable = true;

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "23.05";
}
