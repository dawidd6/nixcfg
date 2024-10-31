{
  pkgs,
  inputs,
  outputs,
  userName,
  hostDir,
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
    users."${userName}" = import "${hostDir}/home.nix";
    extraSpecialArgs = {
      inherit inputs outputs userName;
    };
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  services.displayManager.autoLogin.user = userName;
}
