{
  nixConfig = {
    extra-substituters = [ "https://dawidd6.cachix.org" ];
    extra-trusted-public-keys = [ "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ=" ];
  };

  inputs = {
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
      inputs.flake-parts.follows = "flake-parts";
      inputs.home-manager.follows = "";
      inputs.nuschtosSearch.follows = "";
      inputs.devshell.follows = "";
      inputs.flake-compat.follows = "";
      inputs.git-hooks.follows = "";
      inputs.nix-darwin.follows = "";
      inputs.treefmt-nix.follows = "";
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
      inputs.gitignore.follows = "";
      inputs.flake-compat.follows = "";
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
      inputs.treefmt-nix.follows = "";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs.self) outputs;
      inherit (inputs.nixpkgs) lib;
      forAllSystems = function: lib.genAttrs lib.systems.flakeExposed function;
      forAllPkgs =
        input: function: forAllSystems (system: function (import input { inherit system; }) system);
      mkHome =
        system: userName:
        inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = inputs.nixpkgs.legacyPackages.${system};
          modules = [
            ./configs/home/${userName}/home.nix
          ];
          extraSpecialArgs = {
            inherit inputs outputs userName;
          };
        };
      mkNixos =
        hostName:
        inputs.nixpkgs.lib.nixosSystem {
          modules = [
            ./configs/nixos/${hostName}/configuration.nix
          ];
          specialArgs = {
            inherit inputs outputs hostName;
            userName = "dawidd6";
          };
        };
    in
    {
      inherit lib;

      overlays.default = final: prev: {
        # https://github.com/NixOS/nixpkgs/pull/173364
        ansible = prev.ansible.overrideAttrs (oldAttrs: {
          propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ final.python3Packages.jmespath ];
        });
      };

      nixosConfigurations = {
        coruscant = mkNixos "coruscant";
        hoth = mkNixos "hoth";
        yavin = mkNixos "yavin";
      };

      nixosModules = {
        base = {
          imports = lib.filesystem.listFilesRecursive ./modules/nixos/base;
        };
        laptop = {
          imports = lib.filesystem.listFilesRecursive ./modules/nixos/laptop ++ [
            outputs.nixosModules.base
          ];
        };
        server = {
          imports = lib.filesystem.listFilesRecursive ./modules/nixos/server ++ [
            outputs.nixosModules.base
          ];
        };
      };

      homeConfigurations = {
        dawid = mkHome "x86_64-linux" "dawid";
      };

      homeModules.base = {
        imports = lib.filesystem.listFilesRecursive ./modules/home/base;
      };

      checks = forAllSystems (
        system:
        let
          nixosTops = lib.mapAttrs (_: c: c.config.system.build.toplevel) outputs.nixosConfigurations;
          homeTops = lib.mapAttrs (_: c: c.activationPackage) outputs.homeConfigurations;
          allTops = nixosTops // homeTops;
        in
        allTops
        // {
          pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks.treefmt.enable = true;
            hooks.treefmt.package = outputs.formatter.${system};
          };
        }
      );

      devShells = forAllPkgs inputs.nixpkgs (
        pkgs: system: {
          default = pkgs.mkShellNoCC {
            NIX_CONFIG = "experimental-features = nix-command flakes";
            packages = [
              outputs.formatter.${system}
              inputs.nixos-anywhere.packages.${system}.default
            ];
            shellHook = ''
              ${outputs.checks.${system}.pre-commit.shellHook}
            '';
          };
        }
      );

      formatter = forAllPkgs inputs.nixpkgs (
        pkgs: _system:
        inputs.treefmt.lib.mkWrapper pkgs {
          projectRootFile = "flake.nix";
          programs.deadnix.enable = true;
          programs.nixfmt.enable = true;
          programs.statix.enable = true;
          settings.on-unmatched = "info";
        }
      );

      packages = forAllPkgs inputs.nixpkgs (
        pkgs: _system: {
          scripts = pkgs.runCommandNoCCLocal "scripts" { } ''
            mkdir -p $out && cp -R ${./scripts} $out/bin
          '';
        }
      );
    };
}
