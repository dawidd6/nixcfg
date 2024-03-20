{
  nixConfig = {
    extra-substituters = ["https://dawidd6.cachix.org"];
    extra-trusted-public-keys = ["dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ="];
  };

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    hardware.url = "github:nixos/nixos-hardware";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs: let
    inherit (self) outputs;
    inherit (inputs.nixpkgs) lib;
  in
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.pre-commit-hooks.flakeModule
        inputs.treefmt.flakeModule
      ];
      systems = lib.systems.flakeExposed;
      flake = {
        overlays = import ./overlays {inherit inputs;};
        nixosModules = import ./modules/nixos {inherit lib;};
        homeModules = import ./modules/home-manager {inherit lib;};
        nixosConfigurations = import ./hosts {inherit inputs outputs lib;};
        homeConfigurations = import ./users {inherit inputs outputs lib;};
        hostNames = builtins.toString (builtins.attrNames outputs.hostTops);
        hostTops = inputs.nixpkgs.lib.mapAttrs (_: c: c.config.system.build.toplevel) outputs.nixosConfigurations;
      };
      perSystem = {
        pkgs,
        config,
        ...
      }: {
        checks = outputs.hostTops // (inputs.nixpkgs.lib.mapAttrs (_: c: c.activationPackage) outputs.homeConfigurations);
        devShells.default = pkgs.mkShellNoCC {
          NIX_CONFIG = "experimental-features = nix-command flakes";
          packages = with pkgs; [git neovim];
          shellHook = ''
            ${config.pre-commit.devShell.shellHook}
          '';
        };
        packages = import ./pkgs {inherit pkgs;};
        pre-commit.settings.hooks.treefmt.enable = true;
        treefmt = {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          programs.deadnix.enable = true;
          programs.statix.enable = true;
          programs.yamlfmt.enable = true;
        };
      };
    };
}
