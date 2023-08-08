{
  inputs,
  outputs,
  ...
}: {
  dawid = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs {system = "x86_64-linux";};
    modules = [./dawid.nix];
    extraSpecialArgs = {inherit inputs outputs;};
  };
}
