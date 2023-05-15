{
  description = "NixOS configurations for dawidd6's machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, home-manager-unstable, ... }@inputs: {
    nixosConfigurations = {
      "zotac" = nixpkgs.lib.nixosSystem {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/hosts/zotac.nix
        ];
      };
    };
    homeConfigurations = {
      "dawid" = home-manager-unstable.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./home-manager/users/dawid.nix
          ./home-manager/features/bat.nix
          ./home-manager/features/fish.nix
          ./home-manager/features/fzf.nix
          ./home-manager/features/gh.nix
          ./home-manager/features/git.nix
          ./home-manager/features/htop.nix
          ./home-manager/features/jq.nix
          ./home-manager/features/less.nix
          ./home-manager/features/manual.nix
          ./home-manager/features/neovim.nix
          ./home-manager/features/podman.nix
          ./home-manager/features/starship.nix
          ./home-manager/features/tealdeer.nix
          ./home-manager/features/tools.nix
          ./home-manager/features/zoxide.nix
        ];
      };
    };
  };
}
