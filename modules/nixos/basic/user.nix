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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7iPyyt5SiB7irTbJHMPEJOWhCW+UBhPcNUjZnYAQyB dawidd6@coruscant"
    ];
  };
}
