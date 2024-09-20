{ pkgs, ... }:
{
  home.packages = with pkgs; [
    podman
    podman-compose
  ];

  xdg.configFile = {
    "containers/policy.json".text = ''
      {"default":[{"type":"insecureAcceptAnything"}]}
    '';
    "containers/registries.conf".text = ''
      unqualified-search-registries=["docker.io"]
    '';
    "containers/storage.conf".text = ''
      [storage]
      driver = "overlay"
    '';
  };
}
