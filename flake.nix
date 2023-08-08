{
  nixConfig = {
    extra-substituters = ["https://dawidd6.cachix.org"];
    extra-trusted-public-keys = ["dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    systems.url = "github:nix-systems/default-linux";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
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
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = import inputs.systems;
      flake = {
        overlays = import ./overlays;
        nixosModules = import ./modules/nixos;
        homeModules = import ./modules/home-manager;
        nixosConfigurations = import ./hosts {inherit inputs outputs;};
        homeConfigurations = import ./users {inherit inputs outputs;};
      };
      perSystem = {pkgs, ...}: {
        devShells = import ./shell.nix {inherit pkgs;};
        packages = import ./pkgs {inherit pkgs;};
        formatter = inputs.treefmt.lib.mkWrapper pkgs ./treefmt.nix;
        checks = with inputs.nixpkgs.lib;
          (mapAttrs (_: c: c.config.system.build.toplevel) outputs.nixosConfigurations)
          // (mapAttrs (_: c: c.activationPackage) outputs.homeConfigurations);
      };
    };
}
