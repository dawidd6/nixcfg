{ inputs, modulesPath, ... }:
{
  imports = [
    #(modulesPath + "/profiles/perlless.nix")
    (modulesPath + "/profiles/minimal.nix")

    ./disko-config.nix

    inputs.disko.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;

  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7iPyyt5SiB7irTbJHMPEJOWhCW+UBhPcNUjZnYAQyB dawidd6@coruscant"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFYlpP/NkexiW9B26EnMS6JLE/D35iu7KbKO1eFOcsr dawid@ThinkPad-T14-Gen-1"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "24.11";
}
