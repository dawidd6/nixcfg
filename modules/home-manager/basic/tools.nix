{ pkgs, inputs, ... }:
{
  imports = [ inputs.nix-index-database.hmModules.nix-index ];

  home.packages =
    (with pkgs; [
      ansible
      ansible-lint
      btop
      cloc
      cpio
      curl
      diffoscopeMinimal
      distrobox
      dos2unix
      file
      fx
      gh
      ghorg
      glab
      gnumake
      htop
      ipcalc
      jq
      lm_sensors
      ncdu
      nmap
      nodejs
      nurl
      ruby
      shellcheck
      sshpass
      strace
      tealdeer
      tmux
      trash-cli
      tree
      unzip
      wget
      xsel
      yubikey-manager
    ])
    ++ (with pkgs.unstable; [
      nil
      nix-diff
      nix-init
      nix-tree
      nix-update
      nixfmt-rfc-style
      nixos-shell
      nixpkgs-review
      nvd
    ]);

  programs.fzf.enable = true;
  programs.less.enable = true;
}
