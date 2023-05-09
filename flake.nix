{
  description = "NixOS configurations for dawidd6's machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosModules = {
      #test = import ./nixos/modules/test.nix
    };
    nixosConfigurations = {
      "zotac" = nixpkgs.lib.nixosSystem {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/hosts/zotac.nix
        ];
      };
    };
    homeManagerModules = {
      #test = import ./home-manager/modules/test.nix
    };
    homeConfigurations = {
      "dawidd6" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home-manager/users/dawidd6.nix
        ];
      };
    };
  };
}
