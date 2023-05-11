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
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.fish.enable = true;
  programs.git.enable = true;
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
    diffoscope
    distrobox
    dos2unix
    filezilla
    fzf
    gh
    ghorg
    gimp
    glab
    google-chrome
    gpick
    htop
    inkscape
    ipcalc
    jq
    keepassxc
    lazygit
    libvirt
    lm_sensors
    ncdu
    nmap
    pavucontrol
    podman
    qemu
    sshpass
    spotify
    starship
    strace
    tealdeer
    trash-cli
    tree
    virt-manager
    vorta
    vscode
    xsel
    zoxide
  ];
  home.stateVersion = "22.11";
}
