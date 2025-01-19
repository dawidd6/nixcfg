{
  userName,
  ...
}:
{
  users.users."${userName}" = {
    isNormalUser = true;
    description = userName;
    initialPassword = "changeme";
    extraGroups = [ "wheel" ];
  };
}
