{ pkgs, ... }:
{
  home.packages = [ pkgs.carapace ];

  xdg.configFile =
    let
      commands = [
        "nix-build"
        "nix-instantiate"
        "nix-shell"
        "nixos-rebuild"
      ];
      genAttr = cmd: {
        name = "fish/completions/${cmd}.fish";
        value.source = pkgs.runCommand "${cmd}-fish-completion" { } ''
          ${pkgs.carapace}/bin/carapace ${cmd} fish > $out
          if [ ! -s $out ]; then
            echo "'${cmd}' not recognized by carapace!"
            exit 1
          fi
        '';
      };
    in
    builtins.listToAttrs (builtins.map genAttr commands);
}
