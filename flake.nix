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

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      forEachSystem = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
      forEachPkgs = f: forEachSystem (sys: f nixpkgs.legacyPackages.${sys});
      mkNixos = hostname: nixpkgs.lib.nixosSystem {
        modules = [ ./nixos/hosts/${hostname} ];
        specialArgs = { inherit inputs outputs; };
      };
      mkHome = username: system: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home-manager/users/${username} ];
        extraSpecialArgs = { inherit inputs outputs; };
      };
    in rec {
      packages = forEachPkgs (pkgs: import ./pkgs {inherit pkgs;});
      devShells = forEachPkgs (pkgs: import ./shell.nix {inherit pkgs;});
      overlays = import ./overlays {inherit inputs outputs;};
      nixosModules = import ./modules/nixos;
      nixosConfigurations = {
        "zotac" = mkNixos "zotac";
        "t440s" = mkNixos "t440s";
      };
      homeManagerModules = import ./modules/home-manager;
      homeConfigurations = {
        "dawidd6" = mkHome "dawidd6" "x86_64-linux";
        "dawid" = mkHome "dawid" "x86_64-linux";
      };
    };
}
