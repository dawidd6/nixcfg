{
  additions = final: _prev: import ../pkgs {pkgs = final;};
  modifications = final: prev: {
    # https://github.com/NixOS/nixpkgs/pull/173364
    ansible = prev.ansible.overrideAttrs (oldAttrs: {
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [final.python3Packages.jmespath];
    });
    multipass = prev.multipass.overrideAttrs (oldAttrs: {
      src = prev.fetchFromGitHub {
        inherit (oldAttrs.src) owner repo rev;
        hash = "sha256-fy8i6L0xo+Q1unvhOb0jnQL6P84lxKZ1OGvoTOVJHHk=";
        leaveDotGit = true;
        fetchSubmodules = true;
      };
    });
  };
}
