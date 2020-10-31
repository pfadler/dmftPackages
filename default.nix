{ pkgs ? (import (
    let
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
    in
    with lock.nodes.nixpkgs.locked; fetchTarball {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      sha256 = narHash;
    }
  ) {})
}:
(import ./overlay.nix null pkgs).dmftPackages
