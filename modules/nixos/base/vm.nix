{
  lib,
  pkgs,
  config,
  userName,
  ...
}:
let
  shared = {
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
    virtualisation.qemu.consoles = lib.mkIf (!config.services.xserver.enable) [
      "tty0"
      "hvc0"
    ];
    virtualisation.qemu.options =
      lib.optionals (!config.services.xserver.enable) [
        "-serial null"
        "-device virtio-serial"
        "-chardev stdio,mux=on,id=char0,signal=off"
        "-mon chardev=char0,mode=readline"
        "-device virtconsole,chardev=char0,nr=0"
      ]
      ++ lib.optionals config.services.xserver.enable [
        "-device virtio-vga"
        "-display gtk,grab-on-hover=on"
      ];

    services.getty.helpLine = ''
      If you are connect via serial console:
      Type Ctrl-a c to switch to the qemu console
      and `quit` to stop the VM.
    '';

    services.getty.autologinUser = lib.mkIf (!config.services.xserver.enable) userName;

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
    services.sshd.enable = true;

    environment.systemPackages = with pkgs; [
      babelfish
      xterm # for resize command
    ];

    environment.loginShellInit = ''
      # if terminal with stdout, fix terminal size
      if [ -t 1 ]; then
        case "$SHELL" in
          *fish*)
            eval "$(resize | babelfish)"
            ;;
          *)
            eval "$(resize)"
            ;;
        esac
      fi
    '';
  };
in
{
  virtualisation.vmVariant = shared;
  virtualisation.vmVariantWithDisko = shared;
}
