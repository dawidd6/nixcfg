{pkgs, ...}: {
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
    htop
    ipcalc
    jq
    lazygit
    lm_sensors
    ncdu
    nmap
    sshpass
    strace
    tealdeer
    trash-cli
    tree
    xsel
  ];
}
