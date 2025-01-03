{
  nixConfig = {
    extra-substituters = [ "https://dawidd6.cachix.org" ];
    extra-trusted-public-keys = [ "dawidd6.cachix.org-1:dvy2Br48mAee39Yit5P+jLLIUR3gOa1ts4w4DTJw+XQ=" ];
  };

  inputs = {
    hardware.url = "github:nixos/nixos-hardware";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nuschtosSearch.follows = "";
      inputs.devshell.follows = "";
      inputs.flake-compat.follows = "";
      inputs.git-hooks.follows = "";
      inputs.home-manager.follows = "";
      inputs.nix-darwin.follows = "";
      inputs.treefmt-nix.follows = "";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs.self) outputs;
      inherit (inputs.nixpkgs) lib;
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [ outputs.overlays.default ];
      };
    in
    {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = import ./hosts { inherit inputs outputs lib; };
      nixosModules = import ./modules/nixos { inherit lib; };
      nixosNames = builtins.toString (builtins.attrNames outputs.nixosTops);
      nixosTops = lib.mapAttrs (_: c: c.config.system.build.toplevel) outputs.nixosConfigurations;
      nixosTopsVM = lib.mapAttrs (_: c: c.config.system.build.vm) outputs.nixosConfigurations;
      homeConfigurations = import ./users { inherit inputs outputs lib; };
      homeModules = import ./modules/home-manager { inherit lib; };
      homeNames = builtins.toString (builtins.attrNames outputs.homeTops);
      homeTops = lib.mapAttrs (_: c: c.activationPackage) outputs.homeConfigurations;
      checks.${system} =
        outputs.nixosTops
        // outputs.homeTops
        // {
          pre-commit = inputs.pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks.treefmt.enable = true;
            hooks.treefmt.package = outputs.formatter.${system};
          };
        };
      devShells.${system}.default = pkgs.mkShellNoCC {
        NIX_CONFIG = "experimental-features = nix-command flakes";
        shellHook = ''
          ${outputs.checks.${system}.pre-commit.shellHook}
        '';
      };
      formatter.${system} = inputs.treefmt.lib.mkWrapper pkgs {
        projectRootFile = "flake.nix";
        programs.deadnix.enable = true;
        programs.nixfmt.enable = true;
        programs.statix.enable = true;
      };
      packages.${system} = import ./pkgs { inherit pkgs lib; };
    };
}
