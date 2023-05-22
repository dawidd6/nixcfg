{
  description = "NixOS configurations for dawidd6's machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    hardware,
    home-manager,
    treefmt,
    ...
  } @ inputs: rec {
    devShells.x86_64-linux = import ./shell.nix {pkgs = nixpkgs.legacyPackages.x86_64-linux;};
    formatter.x86_64-linux =
      treefmt.lib.mkWrapper nixpkgs.legacyPackages.x86_64-linux
      {
        projectRootFile = "flake.nix";
        programs.alejandra.enable = true;
        programs.deadnix.enable = true;
      };
    checks.x86_64-linux = let
      os = nixpkgs.lib.mapAttrs (_: c: c.config.system.build.toplevel) nixosConfigurations;
      hm = nixpkgs.lib.mapAttrs (_: c: c.activationPackage) homeConfigurations;
    in
      os // hm;
    nixosConfigurations = {
      "zotac" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostname = "zotac";
        };
        modules = [
          ./hardware/zotac.nix
          ./hosts/zotac.nix
          ./modules/nixos/basic.nix
        ];
      };
      "t440s" = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          hostname = "t440s";
        };
        modules = [
          hardware.nixosModules.lenovo-thinkpad-t440s
          hardware.nixosModules.common-pc-ssd
          ./hardware/t440s.nix
          ./hosts/t440s.nix
          ./modules/nixos/basic.nix
          ./modules/nixos/graphical.nix
        ];
      };
    };
    homeConfigurations = {
      "dawidd6" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          username = "dawidd6";
        };
        modules = [
          ./modules/home-manager/basic.nix
          ./modules/home-manager/graphical.nix
        ];
      };
      "dawid" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          username = "dawid";
        };
        modules = [
          ./modules/home-manager/basic.nix
        ];
      };
    };
  };
}
