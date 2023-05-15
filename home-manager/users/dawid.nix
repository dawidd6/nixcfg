{ inputs, config, pkgs, ... }: {
  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs-unstable;
    home-manager.flake = inputs.home-manager-unstable;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;

  home.username = "dawid";
  home.homeDirectory = "/home/dawid";
  home.stateVersion = "22.11";
}
