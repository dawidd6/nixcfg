{
  hostName,
  config,
  lib,
  pkgs,
  ...
}:
let
  tokenFile = "/secrets/cloudflared.token";
  serviceName = "cloudflared-tunnel-${hostName}";
  serviceScriptName = "${serviceName}-script";
  serviceScript = pkgs.writeShellApplication {
    name = serviceScriptName;
    text = ''
      TUNNEL_TOKEN="$(cat '${tokenFile}')"
      export TUNNEL_TOKEN
      ${config.services.cloudflared.package}/bin/cloudflared tunnel --no-autoupdate run
    '';
  };
in
{
  services.cloudflared = {
    enable = false;
    tunnels = {
      "${hostName}" = {
        credentialsFile = tokenFile;
        default = "";
      };
    };
  };

  systemd.services."${serviceName}".serviceConfig.ExecStart =
    lib.mkForce "${lib.getExe serviceScript}";
}
