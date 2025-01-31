{
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = [ inputs.self.packages.${pkgs.system}.scripts ];

}
