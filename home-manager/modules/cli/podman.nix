{pkgs, ...}: {
  home.packages = [pkgs.podman];

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
