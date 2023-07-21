{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    (pkgs.buildEnv {
      name = "my-scripts";
      paths = ["${inputs.self}/scripts"];
      extraPrefix = "/bin";
    })
  ];
}
