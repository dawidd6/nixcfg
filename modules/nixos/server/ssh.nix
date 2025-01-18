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
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFYlpP/NkexiW9B26EnMS6JLE/D35iu7KbKO1eFOcsr dawid@ThinkPad-T14-Gen-1"
  ];
}