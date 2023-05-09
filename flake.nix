{
  description = "NixOS configurations for dawidd6's machines";

  inputs = {
    # Stable
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs, home-manager, nixpkgs-unstable, home-manager-unstable, ... }: {
    nixosConfigurations = {
      "zotac" = nixpkgs.lib.nixosSystem {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./nixos/zotac
        ];
      };
    };
    homeConfigurations = {
      "dawidd6" = home-manager-unstable.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
        modules = [
          ./home-manager
        ];
      };
      "dawid" = home-manager-unstable.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
        modules = [
          ./home-manager
        ];
      };
    };
  };
}
