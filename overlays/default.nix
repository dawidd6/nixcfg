{
  additions = final: _prev: import ../pkgs {pkgs = final;};
  modifications = final: prev: {
    # https://github.com/NixOS/nixpkgs/pull/173364
    ansible = prev.ansible.overrideAttrs (oldAttrs: {
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [final.python3Packages.jmespath];
    });
  };
}
