{
  outputs,
  pkgs,
  ...
}: {
  imports = [
    outputs.homeModules.basic
  ];

  home.packages = [pkgs.onedrive];

  systemd.user.services.onedrive = {
    Unit.Description = "Onedrive sync service";
    Install.WantedBy = ["default.target"];
    Service = {
      Environment = [
        "Environment=HTTP_PROXY=http://10.144.1.10:8080"
        "Environment=HTTPS_PROXY=http://10.144.1.10:8080"
      ];
      Type = "simple";
      ExecStart = ''
        ${pkgs.onedrive}/bin/onedrive --monitor --confdir=%h/.config/onedrive
      '';
      Restart = "on-failure";
      RestartSec = 3;
      RestartPreventExitStatus = 3;
    };
  };

  home.stateVersion = "22.11";
  home.username = "dawid";
}
