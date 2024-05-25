{
  system ? builtins.currentSystem,
  username ? builtins.getEnv "USER",
  homedir ? builtins.getEnv "HOME",
  desktop ? true,
  nixpkgs ? ./nixpkgs,
  home-manager ? ./home-manager,
  ...
}: rec {
  vmBuild = vmSystem.config.system.build.vm;
  vmSystem = import (nixpkgs + "/nixos/lib/eval-config.nix") {
    inherit system;
    modules = [
      (home-manager + "/nixos")
      ./configuration.nix
    ];
    specialArgs = {
      inherit username homedir desktop;
    };
  };
}
