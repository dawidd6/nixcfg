{ mkModule, ... }:
let
  userName = "dawidd6";
in
mkModule {
  onNixos = {
    _module.args.userName = userName;

    users.users."${userName}" = {
      isNormalUser = true;
      description = userName;
      initialPassword = "changeme";
      extraGroups = [ "wheel" ];
    };
  };
}
