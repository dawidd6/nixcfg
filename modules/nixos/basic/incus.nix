{
  config,
  lib,
  ...
}:
{
  virtualisation.incus.enable = true;
  virtualisation.incus.socketActivation = true;

  # https://github.com/NixOS/nixpkgs/pull/355645
  systemd.services.incus-user = {
    description = "Incus Container and Virtual Machine Management User Daemon";

    environment = lib.mkForce config.systemd.services.incus.environment;

    after = [
      "incus.service"
      "incus-user.socket"
    ];

    requires = [
      "incus-user.socket"
    ];

    serviceConfig = {
      ExecStart = "${config.virtualisation.incus.package}/bin/incus-user --group incus";

      Restart = "on-failure";
    };
  };
  systemd.sockets.incus-user = {
    description = "Incus user UNIX socket";
    wantedBy = [ "sockets.target" ];

    socketConfig = {
      ListenStream = "/var/lib/incus/unix.socket.user";
      SocketMode = "0660";
      SocketGroup = "incus";
    };
  };
  users.groups.incus = { };
}
