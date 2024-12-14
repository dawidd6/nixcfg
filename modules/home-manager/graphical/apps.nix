{ pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      dconf-editor
      filezilla
      firefox
      fritzing
      gimp
      gnome-boxes
      gnome-power-manager
      gnome-tweaks
      google-chrome
      gpick
      gscan2pdf
      inkscape
      keepassxc
      krita
      libreoffice
      lutris
      mission-center
      pavucontrol
      quickemu
      remmina
      signal-desktop
      spotify
      yubioath-flutter
    ])
    ++ (with pkgs.unstable; [ vscode ]);
}
