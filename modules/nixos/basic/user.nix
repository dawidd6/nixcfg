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

  options.home = lib.mkOption { };

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
    };

    home-manager = {
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
