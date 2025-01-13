{
  pkgs,
  ...
}:
{
  xdg.configFile."containers/policy.json".text = ''
    {"default":[{"type":"insecureAcceptAnything"}]}
  '';
  xdg.configFile."containers/registries.conf".text = ''
    unqualified-search-registries=["docker.io"]
  '';
  xdg.configFile."containers/storage.conf".text = ''
    [storage]
    driver = "overlay"
  '';
  xdg.configFile."containers/containers.conf".text = ''
    [network]
    default_subnet="172.16.10.0/24"
    default_subnet_pools = [
      {"base" = "172.16.11.0/24", "size" = 24},
      {"base" = "172.16.12.0/24", "size" = 24},
      {"base" = "172.16.13.0/24", "size" = 24},
      {"base" = "172.16.14.0/24", "size" = 24},
      {"base" = "172.16.15.0/24", "size" = 24},
      {"base" = "172.16.16.0/24", "size" = 24},
      {"base" = "172.16.17.0/24", "size" = 24},
      {"base" = "172.16.18.0/24", "size" = 24},
      {"base" = "172.16.19.0/24", "size" = 24},
      {"base" = "172.16.20.0/24", "size" = 24},
    ]
  '';

  home.packages = with pkgs; [
    podman
    podman-compose
  ];
}
