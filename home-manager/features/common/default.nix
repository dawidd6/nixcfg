{ inputs, config, pkgs, ... }: {
  nix.registry.nixpkgs.flake = inputs.nixpkgs-unstable;
  nix.registry.home-manager.flake = inputs.home-manager-unstable;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  xdg.configFile = {
    "containers/policy.json".text = ''
      {"default":[{"type":"insecureAcceptAnything"}]}
    '';
    "containers/registries.conf".text = ''
      unqualified-search-registries=["docker.io"]
    '';
    "containers/storage.conf".text = ''
      [storage]
      driver = "overlay"
    '';
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ansible
    ansible-lint
    bat
    btop
    cpio
    curl
    diff-so-fancy
    diffoscopeMinimal
    distrobox
    dos2unix
    fish
    fzf
    gh
    ghorg
    git
    glab
    htop
    ipcalc
    jq
    lazygit
    lm_sensors
    ncdu
    nmap
    podman
    sshpass
    starship
    strace
    tealdeer
    trash-cli
    tree
    xsel
    zoxide
  ];
  home.stateVersion = "22.11";
}
