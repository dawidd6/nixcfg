{ inputs, config, pkgs, modulesPath, ... }: {
  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_GB.UTF-8";

  console.keyMap = "pl2";

  services.xserver = {
    layout = "pl";
    xkbVariant = "";
  };
}
