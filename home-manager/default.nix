{ inputs, config, pkgs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    stateVersion = "22.11";
    username = "dawidd6";
    homeDirectory = "/home/dawidd6";
    packages = [
      pkgs.htop
      pkgs.ghorg
      pkgs.podman
      pkgs.spotify
      pkgs.keepassxc
      pkgs.google-chrome
      pkgs.vscode
      pkgs.copyq
      pkgs.vorta
    ];
  };

  programs = {
    neovim = {
      enable = true;
      #defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    home-manager.enable = true;
    fish.enable = true;
  };

  xdg.configFile = {
    "containers/policy.json".text = "{\"default\":[{\"type\":\"insecureAcceptAnything\"}]}";
    "containers/registries.conf".text = "unqualified-search-registries=[\"docker.io\"]";
  };
}
