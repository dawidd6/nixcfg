{ config, pkgs, ... }: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  targets.genericLinux.enable = true;

  home.stateVersion = "22.11";
  home.username = "dawidd6";
  home.homeDirectory = "/home/dawidd6";
  home.packages = [                               
    pkgs.htop
    pkgs.ghorg
    pkgs.podman
    pkgs.copyq
    pkgs.spotify
    pkgs.keepassxc
    pkgs.google-chrome
    pkgs.vscode
    pkgs.vorta

    pkgs.virt-manager
    pkgs.libvirt
    pkgs.qemu
  ];

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.fish.enable = true;
  programs.home-manager.enable = true;

  xdg.configFile."containers/policy.json".text = ''
    {"default":[{"type":"insecureAcceptAnything"}]}
  '';
  xdg.configFile."containers/registries.conf".text = ''
    unqualified-search-registries=["docker.io"]
  '';
}
