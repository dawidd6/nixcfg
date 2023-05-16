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
  };

  outputs = {
    nixpkgs,
    home-manager,
    hardware,
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
  in {
    devShells.${system} = import ./shell.nix {inherit pkgs;};
    formatter.${system} = pkgs.alejandra;
    nixosConfigurations = {
      "zotac" = mkNixos [
        ./hardware/zotac.nix
        ./hosts/zotac.nix
      ];
      "t440s" = mkNixos [
        hardware.nixosModules.lenovo-thinkpad-t440s
        hardware.nixosModules.common-pc-ssd
        ./hardware/t440s.nix
        ./hosts/t440s.nix
      ];
    };
    homeConfigurations = {
      "dawidd6" = mkHome [
        ./users/dawidd6.nix
        ./modules/home-manager/cli.nix
        ./modules/home-manager/gui.nix
      ];
      "dawid" = mkHome [
        ./users/dawid.nix
        ./modules/home-manager/cli.nix
      ];
    };
  };
}
