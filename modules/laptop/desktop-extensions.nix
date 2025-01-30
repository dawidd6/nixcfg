{ mkModule, pkgs, ... }:
let
  gnomeExtensions = with pkgs.gnomeExtensions; [
    appindicator
    clipboard-indicator
  ];
in
mkModule {
  onNixos = {
    environment.systemPackages = gnomeExtensions;

    programs.dconf.profiles.user.databases = [
      {
        settings = {
          "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = map (extension: extension.extensionUuid) gnomeExtensions;
          };
        };
      }
    ];
  };
}
