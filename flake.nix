{
  nixConfig = {
    extra-substituters = [ "https://dawidd6.cachix.org" ];
    extra-trusted-public-keys = [ "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ=" ];
  };

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

  outputs = inputs: rec {
    lib = import ./lib.nix { inherit inputs; };

    overlays.default = import ./overlay.nix;

    nixosConfigurations = {
      coruscant = lib.mkNixos "coruscant";
      hoth = lib.mkNixos "hoth";
      yavin = lib.mkNixos "yavin";
    };

    homeConfigurations = {
      dawid = lib.mkHome "dawid" "x86_64-linux";
    };

    nixosModules = {
      base = lib.mkModules ./modules/base;
      laptop = lib.mkModules ./modules/laptop;
      server = lib.mkModules ./modules/server;
    };

    homeModules = {
      base = lib.mkModules ./modules/base;
      laptop = lib.mkModules ./modules/laptop;
      server = lib.mkModules ./modules/server;
    };

    checks = lib.forAllSystems (
      system:
      let
        nixosTops = lib.mapAttrs (_: c: c.config.system.build.toplevel) nixosConfigurations;
        homeTops = lib.mapAttrs (_: c: c.activationPackage) homeConfigurations;
        allTops = nixosTops // homeTops;
      in
      allTops
      // {
        pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks.treefmt.enable = true;
          hooks.treefmt.package = formatter.${system};
        };
      }
    );

    devShells = lib.forAllPkgs inputs.nixpkgs (
      pkgs: system: {
        default = pkgs.mkShellNoCC {
          NIX_CONFIG = "experimental-features = nix-command flakes";
          packages = [
            formatter.${system}
          ];
          shellHook = ''
            ${checks.${system}.pre-commit.shellHook}
          '';
        };
      }
    );

    formatter = lib.forAllPkgs inputs.nixpkgs (
      pkgs: _system:
      inputs.treefmt.lib.mkWrapper pkgs {
        projectRootFile = "flake.nix";
        programs.deadnix.enable = true;
        programs.nixfmt.enable = true;
        programs.statix.enable = true;
        settings.on-unmatched = "info";
      }
    );

    packages = lib.forAllPkgs inputs.nixpkgs (
      pkgs: system: {
        inherit (inputs.nixos-anywhere.packages.${system}) nixos-anywhere;
        inherit (inputs.disko.packages.${system}) disko;
        inherit (inputs.disko.packages.${system}) disko-install;
        scripts = pkgs.callPackage ./pkgs/scripts.nix { inherit inputs; };
      }
    );
  };
}
