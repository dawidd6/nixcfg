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
    self,
    nixpkgs,
    hardware,
    home-manager,
    treefmt,
    ...
  } @ inputs: let
    inherit (self) outputs;
    inherit (nixpkgs.lib.filesystem) listFilesRecursive;
    inherit (nixpkgs.lib) mapAttrs genAttrs;
    username = "dawidd6";
    eachSystem = genAttrs [
      "aarch64-linux"
      "x86_64-linux"
    ];
    eachSystemPkgs = f: eachSystem (system: f (import nixpkgs {inherit system;}));
  in rec {
    devShells = eachSystemPkgs (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = eachSystemPkgs (pkgs: treefmt.lib.mkWrapper pkgs ./treefmt.nix);
    packages = eachSystemPkgs (pkgs: import ./pkgs {inherit pkgs;});
    overlays = import ./overlays {};
    checks = eachSystemPkgs (
      pkgs:
        (mapAttrs (_: c: c.config.system.build.toplevel) nixosConfigurations)
        // {dawid = homeConfigurations.dawid.activationPackage;}
        // (overlays.modifications pkgs pkgs)
        // (overlays.additions pkgs pkgs)
    );
    nixosModules = {
      default = _: {imports = [home-manager.nixosModules.default];};
      basic = _: {imports = listFilesRecursive ./modules/nixos/basic;};
      graphical = _: {imports = listFilesRecursive ./modules/nixos/graphical;};
    };
    homeModules = {
      basic = _: {imports = listFilesRecursive ./modules/home-manager/basic;};
      graphical = _: {imports = listFilesRecursive ./modules/home-manager/graphical;};
    };
    nixosConfigurations = {
      "t14" = nixpkgs.lib.nixosSystem rec {
        modules = [
          ./hosts/t14/configuration.nix
          hardware.nixosModules.lenovo-thinkpad-t14-amd-gen1
          nixosModules.default
          nixosModules.basic
          nixosModules.graphical
          {
            home-manager = {
              users.${username} = import ./hosts/t14/home.nix;
              extraSpecialArgs = specialArgs;
              sharedModules = [
                homeModules.basic
                homeModules.graphical
              ];
            };
          }
        ];
        specialArgs = {
          inherit inputs outputs username;
          hostname = "t14";
        };
      };
      "t440s" = nixpkgs.lib.nixosSystem rec {
        modules = [
          ./hosts/t440s/configuration.nix
          hardware.nixosModules.lenovo-thinkpad-t440s
          hardware.nixosModules.common-pc-ssd
          nixosModules.default
          nixosModules.basic
          nixosModules.graphical
          {
            home-manager = {
              users.${username} = import ./hosts/t440s/home.nix;
              extraSpecialArgs = specialArgs;
              sharedModules = [
                homeModules.basic
                homeModules.graphical
              ];
            };
          }
        ];
        specialArgs = {
          inherit inputs outputs username;
          hostname = "t440s";
        };
      };
      "zotac" = nixpkgs.lib.nixosSystem rec {
        modules = [
          ./hosts/zotac/configuration.nix
          nixosModules.default
          nixosModules.basic
          {
            home-manager = {
              users.${username} = import ./hosts/zotac/home.nix;
              extraSpecialArgs = specialArgs;
              sharedModules = [
                homeModules.basic
              ];
            };
          }
        ];
        specialArgs = {
          inherit inputs outputs username;
          hostname = "zotac";
        };
      };
    };
    homeConfigurations = {
      dawid = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {system = "x86_64-linux";};
        modules = [
          {
            nixpkgs.overlays = [
              outputs.overlays.additions
              outputs.overlays.modifications
            ];
            home.stateVersion = "22.11";
          }
          homeModules.basic
        ];
        extraSpecialArgs = {
          inherit inputs outputs;
          username = "dawid";
        };
      };
    };
  };
}
