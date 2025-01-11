{
  pkgs,
  inputs,
  outputs,
  lib,
  config,
  ...
}:
let
  userName = "dawidd6";
in
{
  imports = [ inputs.home-manager.nixosModules.default ];

  options.home = lib.mkOption { default = { }; };

  config = {
    users.users."${userName}" = {
      isNormalUser = true;
      description = userName;
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "lp"
        "incus"
      ];
      initialPassword = userName;
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII7iPyyt5SiB7irTbJHMPEJOWhCW+UBhPcNUjZnYAQyB dawidd6@coruscant"
      ];
    };

    home-manager = lib.mkIf (config.home != { }) {
      users."${userName}" = config.home;
      extraSpecialArgs = {
        inherit
          inputs
          outputs
          userName
          ;
      };
      useUserPackages = true;
      useGlobalPkgs = true;
    };

    services.displayManager.autoLogin.user = userName;
  };
}
