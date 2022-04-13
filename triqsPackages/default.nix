{ stdenv, lib, recurseIntoAttrs, callPackage, triqsPackages, python3Packages }:

recurseIntoAttrs ({

  cpp2py = callPackage ./cpp2py { };

  cthyb = callPackage ./cthyb { };

  h5 = callPackage ./h5 { };

  itertools = callPackage ./itertools { };

  maxent = callPackage ./maxent { };

  mpi = callPackage ./mpi { };

  nda = callPackage ./nda { };

  tprf = callPackage ./tprf { };

  triqs = callPackage ./triqs { };

  pyed = python3Packages.callPackage ./pyed { inherit triqsPackages; };

} // lib.optionalAttrs (!stdenv.isDarwin) {

  omegamaxent_interface = callPackage ./omegamaxent_interface { };

})
