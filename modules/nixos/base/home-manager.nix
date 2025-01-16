{
  inputs,
  outputs,
  userName,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs userName;
    };
    useUserPackages = true;
    useGlobalPkgs = true;
  };
}
