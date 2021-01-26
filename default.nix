{ pkgs ? (import
    (
      let
        lock = builtins.fromJSON (builtins.readFile ./flake.lock);
      in
      fetchTarball (with lock.nodes.nixpkgs.locked; {
        url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
        sha256 = narHash;
      })
    )
    { })
}:

with pkgs;
let
  mpiOverride = lib.optionalAttrs (!pkgs ? mpi) { mpi = openmpi; };
  newScope = extra: lib.callPackageWith (pkgs // mpiOverride // extra);
in
lib.makeScope newScope (self:
  with self; {
    alpsPackages = callPackage ./alpsPackages { };

    nfft = callPackage ./nfft { };

    pomerolPackages = callPackage ./pomerolPackages { };

    triqsPackages = callPackage ./triqsPackages { };

    w2dynamics = callPackage ./w2dynamics { };
  })
