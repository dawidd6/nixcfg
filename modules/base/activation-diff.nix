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

  boot.loader.systemd-boot.extraInstallCommands = ''
    if [[ "''${NIXOS_ACTION-}" = boot ]] && [[ -e /run/current-system ]] && [[ -e "''${1-}" ]]; then
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${config.nix.package}/bin diff /run/current-system "''${1-}"
    fi
  '';
}
