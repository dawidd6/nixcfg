{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
  ];

  home.packages = with pkgs; [
    alejandra
    ansible
    ansible-lint
    btop
    cloc
    cpio
    curl
    deadnix
    devbox
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
    nix-init
    nix-tree
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
  services.gpg-agent.enable = true;
  services.gpg-agent.pinentryFlavor = "tty";
  programs.less.enable = true;
}
