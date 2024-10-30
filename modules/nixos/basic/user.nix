{
  pkgs,
  inputs,
  outputs,
  username,
  hostname,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.default ];

  users.users."${username}" = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "lp"
    ];
    initialPassword = username;
    shell = pkgs.fish;
  };

  home-manager = {
    users."${username}" = import "${inputs.self}/hosts/${hostname}/home.nix";
    extraSpecialArgs = {
      inherit inputs outputs username;
    };
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  services.displayManager.autoLogin.user = username;
}
