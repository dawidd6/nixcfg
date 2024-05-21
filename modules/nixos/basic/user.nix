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

  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  users.users."dawidd6" = {
    isNormalUser = true;
    description = "dawidd6";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "lp"];
    initialPassword = "dawidd6";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hmbkp";
    users."dawidd6" = import "${inputs.self}/hosts/${config.networking.hostName}/home.nix";
    extraSpecialArgs = {inherit inputs outputs;};
  };

  services.xserver.displayManager.autoLogin.user = "dawidd6";
}
