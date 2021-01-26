{ recurseIntoAttrs, callPackage, triqsPackages, python3Packages }:

recurseIntoAttrs {

  cpp2py = callPackage ./cpp2py { };

  cthyb = callPackage ./cthyb { };

  h5 = callPackage ./h5 { };

  itertools = callPackage ./itertools { };

  mpi = callPackage ./mpi { };

  triqs = callPackage ./triqs { };

  pyed = python3Packages.callPackage ./pyed { inherit triqsPackages; };

}
