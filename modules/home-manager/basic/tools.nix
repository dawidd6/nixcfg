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
    gh
    ghorg
    glab
    htop
    ipcalc
    jq
    lazygit
    lm_sensors
    ncdu
    nil
    nix-init
    nix-update
    nixpkgs-review
    nmap
    nodejs
    nurl
    nvd
    openstackclient
    python3
    ruby
    sshpass
    strace
    tealdeer
    trash-cli
    tree
    xsel
  ];

  programs.fzf.enable = true;
  programs.gpg.enable = true;
  programs.less.enable = true;
}
