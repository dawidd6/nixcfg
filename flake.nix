{
  nixConfig = {
    extra-substituters = ["https://dawidd6.cachix.org"];
    extra-trusted-public-keys = ["dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default-linux";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs: let
    inherit (self) outputs;
    inherit (inputs.nixpkgs.lib.filesystem) listFilesRecursive;
    inherit (inputs.nixpkgs.lib.attrsets) filterAttrs genAttrs mapAttrs;
    inherit (builtins) readDir attrNames;
    username = "dawidd6";
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      flake = {
        overlays = import ./overlays {};
        nixosModules = {
          basic = _: {imports = listFilesRecursive ./modules/nixos/basic;};
          graphical = _: {imports = listFilesRecursive ./modules/nixos/graphical;};
        };
        homeModules = {
          basic = _: {imports = listFilesRecursive ./modules/home-manager/basic;};
          graphical = _: {imports = listFilesRecursive ./modules/home-manager/graphical;};
        };
        nixosConfigurations = let
          mkNixos = hostname:
            inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {inherit inputs outputs username hostname;};
              modules = [(./hosts + "/${hostname}/configuration.nix")];
            };
          hosts = attrNames (filterAttrs (_: v: v == "directory") (readDir ./hosts));
        in
          genAttrs hosts (hostname: mkNixos hostname);
        homeConfigurations = {
          dawid = inputs.home-manager.lib.homeManagerConfiguration {
            pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
            modules = [
              {
                nixpkgs.overlays = [
                  outputs.overlays.additions
                  outputs.overlays.modifications
                ];
                home.stateVersion = "22.11";
              }
              outputs.homeModules.basic
            ];
            extraSpecialArgs = {
              inherit inputs outputs;
              username = "dawid";
            };
          };
        };
      };
      perSystem = {pkgs, ...}: {
        devShells = import ./shell.nix {inherit pkgs;};
        packages = import ./pkgs {inherit pkgs;};
        formatter = inputs.treefmt.lib.mkWrapper pkgs ./treefmt.nix;
        checks =
          {}
          // (mapAttrs (_: c: c.config.system.build.toplevel) outputs.nixosConfigurations)
          // {dawid = outputs.homeConfigurations.dawid.activationPackage;}
          // (outputs.overlays.modifications pkgs pkgs)
          // (outputs.overlays.additions pkgs pkgs);
      };
    };
}
