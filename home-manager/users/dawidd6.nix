{ inputs, config, pkgs, ... }: {
  nix.registry = {
    nixpkgs.flake = inputs.nixpkgs;
    home-manager.flake = inputs.home-manager;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  programs.home-manager.enable = true;

  home.username = "dawidd6";
  home.homeDirectory = "/home/dawidd6";
  home.stateVersion = "22.11";
}
