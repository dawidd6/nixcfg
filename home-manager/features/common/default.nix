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

  targets.genericLinux.enable = true;

  programs.bash.enable = true;
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ansible
    ansible-lint
    bat
    btop
    cpio
    curl
    copyq
    diff-so-fancy
    diffoscopeMinimal
    distrobox
    dos2unix
    filezilla
    fish
    fzf
    gh
    ghorg
    git
    glab
    google-chrome
    gpick
    htop
    ipcalc
    jq
    keepassxc
    lazygit
    lm_sensors
    ncdu
    nmap
    pavucontrol
    podman
    quickemu
    sshpass
    spotify
    starship
    strace
    tealdeer
    trash-cli
    tree
    vorta
    vscode
    xsel
    zoxide
  ];
  home.stateVersion = "22.11";
}
