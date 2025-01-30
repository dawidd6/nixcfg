{ inputs }:
let
  forAllSystems =
    function: inputs.nixpkgs.lib.genAttrs inputs.nixpkgs.lib.systems.flakeExposed function;
  forAllPkgs =
    input: function: forAllSystems (system: function (import input { inherit system; }) system);
  mkHome =
    userName: system:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      modules = [
        ./configs/home/${userName}/home.nix
      ];
      extraSpecialArgs = {
        inherit inputs userName;
        mkModule = mkHomeModule;
      };
    };
  mkNixos =
    hostName:
    inputs.nixpkgs.lib.nixosSystem {
      modules = [
        ./configs/nixos/${hostName}/configuration.nix
      ];
      specialArgs = {
        inherit inputs hostName;
        mkModule = mkNixosModule;
      };
    };
  mkModules = dir: {
    imports = inputs.nixpkgs.lib.filesystem.listFilesRecursive dir;
  };
  mkModule =
    isNixos:
    {
      onNixos ? { },
      onHome ? { },
      onAny ? { },
    }:
    {
      imports =
        if isNixos then
          [
            onNixos
            onAny
          ]
        else
          [
            onHome
            onAny
          ];
    };
  mkHomeModule = args: mkModule false args;
  mkNixosModule = args: mkModule true args;
in
inputs.nixpkgs.lib.extend (
  _: _: {
    inherit
      forAllSystems
      forAllPkgs
      mkHome
      mkNixos
      mkModules
      ;
  }
)
