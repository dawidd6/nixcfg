{
  pkgs,
  inputs,
  outputs,
  userName,
  version,
  home,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.default ];

  users.users."${userName}" = {
    isNormalUser = true;
    description = userName;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "lp"
    ];
    initialPassword = userName;
    shell = pkgs.fish;
  };

  home-manager = {
    users."${userName}" = home;
    extraSpecialArgs = {
      inherit
        inputs
        outputs
        userName
        version
        ;
    };
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  services.displayManager.autoLogin.user = userName;
}
