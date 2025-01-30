final: prev: {
  # https://github.com/NixOS/nixpkgs/pull/173364
  ansible = prev.ansible.overrideAttrs (oldAttrs: {
    propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ final.python3Packages.jmespath ];
  });
  _1password-gui = prev._1password-gui.overrideAttrs (oldAttrs: {
    installPhase =
      oldAttrs.installPhase
      + ''
        mkdir -p $out/etc/xdg/autostart
        cp $out/share/applications/1password.desktop $out/etc/xdg/autostart/1password.desktop
        substituteInPlace $out/etc/xdg/autostart/1password.desktop \
          --replace-fail 'Exec=1password %U' 'Exec=1password --silent %U'
      '';
  });
}
