{
  nixConfig = {
    extra-substituters = [ "https://dawidd6.cachix.org" ];
    extra-trusted-public-keys = [ "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ=" ];
  };

  inputs = {
    hardware.url = "github:nixos/nixos-hardware";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
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

  outputs =
    inputs:
    let
      userName = "dawidd6";
      inherit (inputs.self) outputs;
      inherit (inputs.nixpkgs) lib;
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = lib.systems.flakeExposed;
      imports = [
        inputs.pre-commit-hooks.flakeModule
        inputs.treefmt.flakeModule
      ];
      flake = {
        overlays = import ./overlays { inherit inputs; };
        nixosConfigurations = import ./hosts {
          inherit
            inputs
            outputs
            lib
            userName
            ;
        };
        nixosModules = import ./modules/nixos { inherit lib; };
        nixosNames = builtins.toString (builtins.attrNames outputs.nixosTops);
        nixosTops = lib.mapAttrs (_: c: c.config.system.build.toplevel) outputs.nixosConfigurations;
        homeConfigurations = import ./users {
          inherit
            inputs
            outputs
            lib
            ;
        };
        homeModules = import ./modules/home-manager { inherit lib; };
        homeNames = builtins.toString (builtins.attrNames outputs.homeTops);
        homeTops = lib.mapAttrs (_: c: c.activationPackage) outputs.homeConfigurations;
      };
      perSystem =
        {
          pkgs,
          config,
          system,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [ outputs.overlays.unstable-packages ];
          };
          checks = outputs.nixosTops // outputs.homeTops;
          devShells.default = pkgs.mkShellNoCC {
            NIX_CONFIG = "experimental-features = nix-command flakes";
            shellHook = ''
              ${config.pre-commit.devShell.shellHook}
            '';
          };
          packages = import ./pkgs { inherit pkgs; };
          pre-commit.settings.hooks.treefmt.enable = true;
          treefmt = {
            projectRootFile = "flake.nix";
            programs.deadnix = {
              enable = true;
              package = pkgs.unstable.deadnix;
            };
            programs.nixfmt = {
              enable = true;
              package = pkgs.unstable.nixfmt-rfc-style;
            };
            programs.statix = {
              enable = true;
              package = pkgs.unstable.statix;
            };
          };
        };
    };
}
