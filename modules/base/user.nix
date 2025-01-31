_:
let
  userName = "dawidd6";
in

{
  _module.args.userName = userName;

  users.users."${userName}" = {
    isNormalUser = true;
    description = userName;
    initialPassword = "changeme";
    extraGroups = [ "wheel" ];
  };
}
