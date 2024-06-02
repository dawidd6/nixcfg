{lib, ...}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "Visual Studio Dark+";
    };
  };

  # TODO: https://github.com/nix-community/home-manager/issues/5481
  home.activation.batCache = lib.mkForce "";
}
