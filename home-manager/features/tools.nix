{ inputs, config, pkgs, ... }: {
  home.packages = with pkgs; [
    ansible
    ansible-lint
    btop
    cpio
    curl
    diffoscopeMinimal
    distrobox
    dos2unix
    ghorg
    glab
    ipcalc
    lazygit
    lm_sensors
    ncdu
    nmap
    sshpass
    strace
    trash-cli
    tree
    xsel
  ];
}
