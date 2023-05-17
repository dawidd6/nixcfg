{
  description = "NixOS configurations for dawidd6's machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    formatter-pack = {
      url = "github:Gerschtli/nix-formatter-pack";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    hardware,
    formatter-pack,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    mkNixos = modules:
      nixpkgs.lib.nixosSystem {
        inherit modules;
        specialArgs = {inherit inputs;};
      };
    mkHome = modules:
      home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
        extraSpecialArgs = {inherit inputs;};
      };
  in rec {
    devShells.${system} = import ./shell.nix {inherit pkgs;};
    formatter.${system} = formatter-pack.lib.mkFormatter {
      inherit pkgs;
      config.tools = {
        alejandra.enable = true;
        deadnix.enable = true;
        statix.enable = true;
      };
    };
    checks.${system} = let
      os = nixpkgs.lib.mapAttrs (_: c: c.config.system.build.toplevel) nixosConfigurations;
      hm = nixpkgs.lib.mapAttrs (_: c: c.activationPackage) homeConfigurations;
    in
      os // hm;
    nixosConfigurations = {
      "zotac" = mkNixos [
        ./nixos/hardware/zotac.nix
        ./nixos/hosts/zotac.nix
      ];
      "t440s" = mkNixos [
        hardware.nixosModules.lenovo-thinkpad-t440s
        hardware.nixosModules.common-pc-ssd
        ./nixos/hardware/t440s.nix
        ./nixos/hosts/t440s.nix
      ];
    };
    homeConfigurations = {
      "dawidd6" = mkHome [
        ./home-manager/users/dawidd6.nix
        ./home-manager/modules/cli.nix
        ./home-manager/modules/gui.nix
      ];
      "dawid" = mkHome [
        ./home-manager/users/dawid.nix
        ./home-manager/modules/cli.nix
      ];
    };
  };
}
