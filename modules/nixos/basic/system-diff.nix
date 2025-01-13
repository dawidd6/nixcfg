{
  pkgs,
  config,
  ...
}:
{
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      if [[ -e /run/current-system ]]; then
        ${pkgs.nvd}/bin/nvd --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "$systemConfig"
      fi
    '';
  };
}
