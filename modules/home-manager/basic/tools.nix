{
  pkgsUnstable,
  inputs,
  ...
}:
{
  imports = [ inputs.nix-index-database.hmModules.nix-index ];

  home.packages = with pkgsUnstable; [
    ansible
    ansible-lint
    btop
    cloc
    cpio
    curl
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
    lm_sensors
    ncdu
    nix-diff
    nix-init
    nix-inspect
    nix-tree
    nix-update
    nixd
    nixfmt-rfc-style
    nixos-shell
    nixpkgs-review
    nmap
    nodejs
    nurl
    nvd
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
    yubikey-manager
  ];

  programs.fzf.enable = true;
  programs.less.enable = true;
}
