{
  userName,
  ...
}:
{
  users.users."${userName}" = {
    isNormalUser = true;
    description = userName;
    initialPassword = userName;
    extraGroups = [ "wheel" ];
  };
}
