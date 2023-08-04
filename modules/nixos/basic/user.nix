{
  inputs,
  outputs,
  pkgs,
  username,
  hostname,
  ...
}: {
  programs.fish.enable = true;

  users.defaultUserShell = pkgs.fish;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    initialPassword = username;
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjPWvOxxVyoaF+sZV4Q32mzU5IR+2OKvT+czFwICMNhBq99V88sMH0V+LOs4YwhvameikF502GANoqNVbqiZgfc2uxV4I/9dvTXo3REx+sB9MNasjiUcbz8cdR7zIb1IWBo19VclRSJDE9UFeGJWL72l4OVEvzocbgsDGStjxPo6kILh0f6wXTJr9XRFxZzA0BeQU3D15qIImxKwxQb21aMaPxhRkEgObQweN30LL6rAtenCCJXwpvjsBoJNTE7ZHo8Mlh7lIkXdZxcb7h7jeK3wvkL2BUrwyBbBMf0rk7rAN73Ei3rqF1qDGENNng20j0CRpFaq/cyUcM9b6rTS+7 dawidd6"];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${username}" = import "${inputs.self}/hosts/${hostname}/home.nix";
    extraSpecialArgs = {inherit inputs outputs hostname username;};
  };
}
