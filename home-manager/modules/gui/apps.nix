{pkgs, ...}: {
  home.packages = with pkgs; [
    filezilla
    gimp
    google-chrome
    gpick
    inkscape
    keepassxc
    pavucontrol
    spotify
    virt-manager
    vorta
    vscode
  ];
}
