{
  inputs,
  outputs,
  ...
}: {
  "t14" = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs outputs;};
    modules = [./t14/configuration.nix];
  };
  "t440s" = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs outputs;};
    modules = [./t440s/configuration.nix];
  };
  "zotac" = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs outputs;};
    modules = [./zotac/configuration.nix];
  };
  "vm" = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {inherit inputs outputs;};
    modules = [./vm/configuration.nix];
  };
}
