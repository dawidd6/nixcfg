{
  pkgs,
  ...
}:
{
  environment.systemPackages =

    with pkgs; [
      ack
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
      python3
      ripgrep
      ruby
      shellcheck
      sshpass
      strace
      tealdeer
      tmux
      tree
      unzip
      wget
    ];

}
