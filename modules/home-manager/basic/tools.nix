{pkgs, ...}: {
  home.packages = with pkgs; [
    alejandra
    ansible
    ansible-lint
    btop
    cloc
    cpio
    curl
    deadnix
    diffoscopeMinimal
    distrobox
    dos2unix
    file
    fx
    gh
    ghorg
    glab
    gnumake
    htop
    ipcalc
    jq
    lazygit
    lm_sensors
    ncdu
    nil
    nix-diff
    nix-index
    nix-init
    nix-update
    nixos-shell
    nixpkgs-review
    nmap
    nodejs
    nurl
    nvd
    openstackclient
    python3
    ruby
    shellcheck
    sshpass
    strace
    tealdeer
    tmux
    trash-cli
    tree
    unzip
    wget
    xsel
  ];

  programs.fzf.enable = true;
  programs.gpg.enable = true;
  programs.less.enable = true;
}
