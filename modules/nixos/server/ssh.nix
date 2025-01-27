{ userName, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = [ userName ];
    };
  };

  users.users."${userName}".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7iPyyt5SiB7irTbJHMPEJOWhCW+UBhPcNUjZnYAQyB dawidd6@coruscant"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBg5okX2Lmqk/kj9kXW/h3D5u0+6bO7jtdd8U4/NT3FE phone"
  ];
}
