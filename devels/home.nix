{
  pkgs,
  osConfig,
  ...
}: {
  home.packages = with pkgs; [
  ];

  home.stateVersion = osConfig.system.nixos.release;
}
