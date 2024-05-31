{
  pkgs,
  config,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  users.users."dawidd6" = {
    isNormalUser = true;
    description = "dawidd6";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "lp"];
    initialPassword = "dawidd6";
    shell = pkgs.fish;
  };

  home-manager = {
    users."dawidd6" = import "${inputs.self}/hosts/${config.networking.hostName}/home.nix";
    extraSpecialArgs = {inherit inputs outputs;};
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  services.xserver.displayManager.autoLogin.user = "dawidd6";
}
