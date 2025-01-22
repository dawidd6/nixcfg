# This is a special configuration for bootstrapping of this host.
# Oracle Cloud free tier only offers 1GB x86_64 machines.
# NixOS installation via nixos-anywhere builds system closure
# and stores it in RAM, which we have not many.
# That's why this minimal configuration exists.
# We deploy NixOS via nixos-anywhere using this configuration
# and then switch to the main configuration no problem.
{ inputs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/profiles/minimal.nix")

    ./disko-config.nix
    ./hardware-configuration.nix

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
