{ inputs, config, pkgs, ... }: {
  home.packages = with pkgs; [
    gnome.gnome-tweaks
    google-chrome
    keepassxc
    vorta
    vscode
  ];
}
