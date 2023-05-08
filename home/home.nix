{ config, pkgs, ... }:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nixpkgs.overlays = [
    (self: super: {
       vorta = super.vorta.overrideAttrs (attrs: {
         postInstall = attrs.postInstall + ''
           install -Dm644 src/vorta/assets/icons/icon.svg $out/share/pixmaps/com.borgbase.Vorta-symbolic.svg
         '';
       });
    })
  ];

  #fonts.fontconfig.enable = true;
  #targets.genericLinux.enable = true;
  programs.bash = {
    enable = true;
    profileExtra = ''
      export XDG_DATA_DIRS=$HOME/.home-manager-share:$XDG_DATA_DIRS
      export XCURSOR_PATH="$XCURSOR_PATH$${XCURSOR_PATH:+:}$HOME/.nix-profile/share/icons:/usr/share/icons:/usr/share/pixmaps"
    '';
  };

  home.activation = {
    linkDesktopApplications = {
      after = [ "writeBoundary" "createXdgUserDirectories" ];
      before = [ ];
      data = ''
        rm -rf $HOME/.home-manager-share
        mkdir -p $HOME/.home-manager-share
        cp -Lr --no-preserve=mode,ownership ${config.home.homeDirectory}/.nix-profile/share/* $HOME/.home-manager-share
      '';
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dawidd6";
  home.homeDirectory = "/home/dawidd6";

  # Packages that should be installed to the user profile.
  home.packages = [                               
    pkgs.htop
    pkgs.ghorg
    pkgs.podman
    pkgs.spotify
    pkgs.keepassxc
    pkgs.google-chrome
    pkgs.vscode
    pkgs.copyq
    pkgs.vorta
  ];

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;

  programs.fish.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.configFile."containers/policy.json".text = ''
    {"default":[{"type":"insecureAcceptAnything"}]}
  '';
  xdg.configFile."containers/registries.conf".text = ''
    unqualified-search-registries=["docker.io"]
  '';
}
