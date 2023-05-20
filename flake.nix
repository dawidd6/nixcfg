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
          ./nixos/hardware/zotac.nix
          ./nixos/hosts/zotac.nix
          ./nixos/modules/basic.nix
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
          ./nixos/hardware/t440s.nix
          ./nixos/hosts/t440s.nix
          ./nixos/modules/basic.nix
          ./nixos/modules/graphical.nix
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
          ./home-manager/modules/basic.nix
          ./home-manager/modules/graphical.nix
        ];
      };
      "dawid" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          username = "dawid";
        };
        modules = [
          ./home-manager/modules/basic.nix
        ];
      };
    };
  };
}
