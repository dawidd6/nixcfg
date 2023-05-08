{
  description = "NixOS configurations for dawidd6's machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: {
    nixosConfigurations = {
      zotac = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
        };
        modules = [
          ./nixos/zotac
        ];
      };
    };
    homeConfigurations = {
      dawidd6 = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs;
          pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
        };
        modules = [
          ./home-manager
        ];
      };
    };
  };
}
