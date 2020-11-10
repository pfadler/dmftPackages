{ lib, newScope, recurseIntoAttrs, nfft, python3Packages }:

lib.makeScope newScope (self: with self; recurseIntoAttrs {

  cpp2py = callPackage ./cpp2py { };

  cthyb = callPackage ./cthyb { inherit nfft; };

  h5 = callPackage ./h5 { };

  itertools = callPackage ./itertools { };

  mpi = callPackage ./mpi { };

  triqs = callPackage ./triqs { };

  pyed = python3Packages.callPackage ./pyed { inherit triqs; };

})
