{
  description = "NixOS configurations for dawidd6's machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    formatter-pack = {
      url = "github:Gerschtli/nix-formatter-pack";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    hardware,
    home-manager,
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
        ./nixos/modules/boot.nix
        ./nixos/modules/locale.nix
        ./nixos/modules/network.nix
        ./nixos/modules/nix.nix
        ./nixos/modules/user.nix
      ];
      "t440s" = mkNixos [
        hardware.nixosModules.lenovo-thinkpad-t440s
        hardware.nixosModules.common-pc-ssd
        ./nixos/hardware/t440s.nix
        ./nixos/hosts/t440s.nix
        ./nixos/modules/boot.nix
        ./nixos/modules/desktop.nix
        ./nixos/modules/laptop.nix
        ./nixos/modules/locale.nix
        ./nixos/modules/network.nix
        ./nixos/modules/nix.nix
        ./nixos/modules/user.nix
      ];
    };
    homeConfigurations = {
      "dawidd6" = mkHome [
        ./home-manager/users/dawidd6.nix
        ./home-manager/modules/cli/bat.nix
        ./home-manager/modules/cli/fish.nix
        ./home-manager/modules/cli/fzf.nix
        ./home-manager/modules/cli/gh.nix
        ./home-manager/modules/cli/git.nix
        ./home-manager/modules/cli/less.nix
        ./home-manager/modules/cli/neovim.nix
        ./home-manager/modules/cli/nix.nix
        ./home-manager/modules/cli/podman.nix
        ./home-manager/modules/cli/scripts.nix
        ./home-manager/modules/cli/starship.nix
        ./home-manager/modules/cli/tools.nix
        ./home-manager/modules/cli/zoxide.nix
        ./home-manager/modules/gui/apps.nix
        ./home-manager/modules/gui/extensions.nix
        ./home-manager/modules/gui/font.nix
        ./home-manager/modules/gui/keybindings.nix
        ./home-manager/modules/gui/tweaks.nix
      ];
      "dawid" = mkHome [
        ./home-manager/users/dawid.nix
        ./home-manager/modules/cli/bat.nix
        ./home-manager/modules/cli/fish.nix
        ./home-manager/modules/cli/fzf.nix
        ./home-manager/modules/cli/gh.nix
        ./home-manager/modules/cli/git.nix
        ./home-manager/modules/cli/less.nix
        ./home-manager/modules/cli/neovim.nix
        ./home-manager/modules/cli/nix.nix
        ./home-manager/modules/cli/podman.nix
        ./home-manager/modules/cli/scripts.nix
        ./home-manager/modules/cli/starship.nix
        ./home-manager/modules/cli/tools.nix
        ./home-manager/modules/cli/zoxide.nix
      ];
    };
  };
}
