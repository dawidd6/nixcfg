{
  inputs = {
    flake-compat.url = "github:edolstra/flake-compat";
    hardware.url = "github:nixos/nixos-hardware";
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.flake-parts.follows = "flake-parts";
      inputs.flake-compat.follows = "flake-compat";
      inputs.git-hooks.follows = "pre-commit-hooks";
      inputs.treefmt-nix.follows = "treefmt";
      inputs.nuschtosSearch.follows = "";
      inputs.devshell.follows = "";
      inputs.nix-darwin.follows = "";
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
      inputs.flake-compat.follows = "flake-compat";
      inputs.gitignore.follows = "";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixos-stable.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.disko.follows = "disko";
      inputs.treefmt-nix.follows = "treefmt";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs) lib;
      mkHome =
        userName: system:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          modules = [
            ./configs/home/${userName}/home.nix
          ];
          extraSpecialArgs = {
            inherit inputs userName;
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
          };
        };
      mkModules = dir: {
        imports = inputs.nixpkgs.lib.filesystem.listFilesRecursive dir;
      };
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;
      imports = [
        inputs.pre-commit-hooks.flakeModule
        inputs.treefmt.flakeModule
      ];
      flake = {
        overlays.default = import ./overlay.nix;

        homeConfigurations = {
          dawid = mkHome "dawid" "x86_64-linux";
        };

        nixosConfigurations = {
          coruscant = mkNixos "coruscant";
          hoth = mkNixos "hoth";
          yavin = mkNixos "yavin";
        };

        nixosModules = {
          base = mkModules ./modules/base;
          laptop = mkModules ./modules/laptop;
          server = mkModules ./modules/server;
        };
      };
      perSystem =
        {
          pkgs,
          system,
          config,
          ...
        }:
        {
          checks =
            let
              nixosTops = lib.mapAttrs (_: c: c.config.system.build.toplevel) inputs.self.nixosConfigurations;
              homeTops = lib.mapAttrs (_: c: c.activationPackage) inputs.self.homeConfigurations;
            in
            nixosTops // homeTops;

          devShells.default = pkgs.mkShellNoCC {
            NIX_CONFIG = "experimental-features = nix-command flakes";
            packages = [
              inputs.self.formatter.${system}
            ];
            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };

          packages = {
            inherit (inputs.nixos-anywhere.packages.${system}) nixos-anywhere;
            inherit (inputs.disko.packages.${system}) disko;
            inherit (inputs.disko.packages.${system}) disko-install;
            scripts = pkgs.callPackage ./pkgs/scripts.nix { inherit inputs; };
          };

          pre-commit.settings.hooks.treefmt.enable = true;

          treefmt = {
            projectRootFile = "flake.nix";
            programs.deadnix.enable = true;
            programs.nixfmt.enable = true;
            programs.statix.enable = true;
            settings.on-unmatched = "info";
          };
        };
    };
}
