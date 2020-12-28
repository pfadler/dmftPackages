{ pkgs ? (import
    (
      let
        lock = builtins.fromJSON (builtins.readFile ./flake.lock);
      in
      with lock.nodes.nixpkgs.locked; fetchTarball {
        url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
        sha256 = narHash;
      }
    )
    { overlays = [ (import ./overlay.nix) ]; })
}:
(if pkgs ? dmftPackages
then pkgs
else pkgs.appendOverlays [ (import ./overlay.nix) ]).dmftPackages
