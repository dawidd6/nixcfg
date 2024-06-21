{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs { pkgs = final; };
  modifications = final: prev: {
    # https://github.com/NixOS/nixpkgs/pull/173364
    ansible = prev.ansible.overrideAttrs (oldAttrs: {
      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ final.python3Packages.jmespath ];
    });
  };
  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
    };
  };
}
