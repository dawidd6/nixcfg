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
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  system.stateVersion = "24.11";
}
