{ inputs, config, pkgs, ... }: {
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  targets.genericLinux.enable = true;

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

  home.packages = [
    pkgs.ansible
    pkgs.ansible-lint
    pkgs.bat
    pkgs.btop
    pkgs.cpio
    pkgs.curl
    pkgs.copyq
    pkgs.diff-so-fancy
    pkgs.diffoscope
    pkgs.distrobox
    pkgs.dos2unix
    pkgs.filezilla
    pkgs.fzf
    pkgs.gh
    pkgs.ghorg
    pkgs.gimp
    pkgs.glab
    pkgs.google-chrome
    pkgs.gpick
    pkgs.htop
    pkgs.inkscape
    pkgs.ipcalc
    pkgs.jq
    pkgs.keepassxc
    pkgs.lazygit
    pkgs.libvirt
    pkgs.lm_sensors
    pkgs.ncdu
    pkgs.nmap
    pkgs.pavucontrol
    pkgs.podman
    pkgs.qemu
    pkgs.sshpass
    pkgs.spotify
    pkgs.starship
    pkgs.strace
    pkgs.tealdeer
    pkgs.trash-cli
    pkgs.tree
    pkgs.virt-manager
    pkgs.vorta
    pkgs.vscode
    pkgs.xsel
    pkgs.zoxide
  ];
  home.username = "dawidd6";
  home.homeDirectory = "/home/dawidd6";
  home.stateVersion = "22.11";
}
