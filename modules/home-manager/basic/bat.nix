{lib, ...}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "Visual Studio Dark+";
    };
  };

  home.activation.batCache = lib.mkForce "";
}
