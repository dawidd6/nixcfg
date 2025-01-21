(import (
  let
    flakeLock = builtins.fromJSON (builtins.readFile ./flake.lock);
    nodeName = flakeLock.nodes.root.inputs.flake-compat;
    lockedNode = flakeLock.nodes.${nodeName}.locked;
  in
  fetchTarball {
    url = "https://github.com/${lockedNode.owner}/${lockedNode.repo}/archive/${lockedNode.rev}.tar.gz";
    sha256 = lockedNode.narHash;
  }
) { src = ./.; }).outputs
