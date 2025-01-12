{
  pkgs,
  lib,
  userName,
  ...
}:
let
  gnomeExtensions = with pkgs.gnomeExtensions; [
    appindicator
    clipboard-indicator
  ];
in
{
  # systemd-boot
  boot.kernelParams = [ "quiet" ];
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.initrd.verbose = false;

  # printer
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.addresses = true;
  services.avahi.publish.userServices = true;

  # scanner
  hardware.sane.enable = true;
  hardware.sane.openFirewall = true;
  hardware.sane.extraBackends = [ pkgs.hplip ];

  # gdm
  # https://github.com/NixOS/nixpkgs/issues/103746
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = userName;
  programs.dconf.profiles.gdm.databases = [
    {
      settings = {
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
        };
        "org/gnome/desktop/interface" = {
          show-battery-percentage = true;
        };
      };
    }
  ];

  # gnome
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = [ pkgs.xterm ];
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = map (extension: extension.extensionUuid) gnomeExtensions;
        };
        "org/gnome/desktop/interface" = {
          font-antialiasing = "rgba";
          font-name = "Ubuntu 11";
          document-font-name = "FreeSans 11";
          monospace-font-name = "UbuntuMono Nerd Font Regular 13";
          color-scheme = "prefer-dark";
          clock-show-weekday = true;
          clock-show-seconds = true;
          show-battery-percentage = true;
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
          titlebar-font = "Ubuntu Bold 11";
        };
        "org/gnome/desktop/peripherals/touchpad" = {
          tap-to-click = true;
          two-finger-scrolling-enabled = true;
        };
        "org/gnome/desktop/calendar" = {
          show-weekdate = true;
        };
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-battery-type = "nothing";
          sleep-inactive-ac-type = "nothing";
          idle-dim = false;
          idle-brightness = lib.gvariant.mkInt32 100;
        };
        "org/gnome/desktop/session" = {
          idle-delay = lib.gvariant.mkUint32 0;
        };
        "org/gnome/desktop/wm/keybindings" = {
          switch-applications = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          switch-applications-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          switch-windows = [ "<Alt>Tab" ];
          switch-windows-backward = [ "<Shift><Alt>Tab" ];
          show-desktop = [ "<Super>d" ];
        };
        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Control><Alt>t";
          command = "kgx";
          name = "Terminal";
        };
        "org/gtk/gtk4/settings/file-chooser" = {
          show-hidden = true;
        };
        "org/gnome/desktop/screensaver" = {
          lock-enabled = false;
        };
      };
    }
  ];

  # TODO: is this needed to specify explicitly?
  # pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.pulse.enable = true;

  # fwupd
  services.fwupd.enable = true;

  # apps
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
  environment.systemPackages =
    (with pkgs; [
      dconf-editor
      eyedropper
      filezilla
      firefox
      fritzing
      gimp
      gnome-power-manager
      gnome-tweaks
      google-chrome
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
      vscode
      yubioath-flutter
    ])
    ++ gnomeExtensions;

  # fonts
  fonts.packages = with pkgs; [
    ubuntu-classic
    (nerdfonts.override {
      fonts = [
        "Ubuntu"
        "UbuntuMono"
      ];
    })
  ];

  # bluetooth
  hardware.bluetooth.powerOnBoot = false;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluez5-experimental;
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
      FastConnectable = true;
    };
  };

  # power
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;
  services.upower.enable = true;

  # nix-ld
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [ ];

  # smartcard
  services.pcscd.enable = true;
  hardware.gpgSmartcards.enable = true;

  # incus
  # TODO: move to separate module/profile?
  virtualisation.incus.enable = true;
  virtualisation.incus.socketActivation = true;
  networking.firewall.interfaces."incusbr*" =
    let
      ports = [
        53
        67
      ];
    in
    {
      allowedTCPPorts = ports;
      allowedUDPPorts = ports;
    };
}
