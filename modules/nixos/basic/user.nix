{
  pkgs,
  config,
  inputs,
  outputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.default];

  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  users.users."dawidd6" = {
    isNormalUser = true;
    description = "dawidd6";
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    initialPassword = "dawidd6";
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjPWvOxxVyoaF+sZV4Q32mzU5IR+2OKvT+czFwICMNhBq99V88sMH0V+LOs4YwhvameikF502GANoqNVbqiZgfc2uxV4I/9dvTXo3REx+sB9MNasjiUcbz8cdR7zIb1IWBo19VclRSJDE9UFeGJWL72l4OVEvzocbgsDGStjxPo6kILh0f6wXTJr9XRFxZzA0BeQU3D15qIImxKwxQb21aMaPxhRkEgObQweN30LL6rAtenCCJXwpvjsBoJNTE7ZHo8Mlh7lIkXdZxcb7h7jeK3wvkL2BUrwyBbBMf0rk7rAN73Ei3rqF1qDGENNng20j0CRpFaq/cyUcM9b6rTS+7 dawidd6"];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hmbkp";
    users."dawidd6" = import "${inputs.self}/hosts/${config.networking.hostName}/home.nix";
    extraSpecialArgs = {inherit inputs outputs;};
  };
}
